#!/bin/python3

import os
import sys
import re
import pandas as pd
import matplotlib.pyplot as plt

class VarnishLogProcessor:
    def __init__(self):
        self.node_log_dict = {}
    
    def load_log(self, log_dir):
        self.log_dir = log_dir
        log_files = os.listdir(log_dir)
        for log_file in log_files:
            if log_file.endswith('.log'):
                self.load_single_log(log_dir + '/' + log_file)

    def load_single_log(self, log_file):
        # parse node name from "./data/varnishstat-node1.log"
        node_name = re.search(r'node\d+', log_file).group()
        print("Processing log file: " + log_file)
        record_time_list = []
        client_request_list = []
        cache_hit_list = []
        with open(log_file, 'r') as f:
            logs = f.readlines()
            # parse log
            for line in logs:
                if "[new epoch]" in line:
                    record_time_list.append(line[1:32])
                elif line.split()[0] == "MAIN.client_req":
                    client_request_list.append(line.split()[1])
                elif line.split()[0] == "MAIN.cache_hit":
                    cache_hit_list.append(line.split()[1])
        
        # create dataframe
        df = pd.DataFrame()
        df['record_time'] = record_time_list
        df['client_request'] = client_request_list
        df['cache_hit'] = cache_hit_list
        df['hit_rate'] = df['cache_hit'].astype(int) / df['client_request'].astype(int)
        self.node_log_dict[node_name] = df

    def visualize_cache_hit(self):
        # get number of nodes
        num_nodes = len(self.node_log_dict)

        # plot cache hit rate
        plt.figure(figsize=(10, 8))
        for node_name, df in self.node_log_dict.items():
            plt.plot(df.index, df['hit_rate'], label=node_name)
        plt.xlabel('Time')
        plt.ylabel('Cache Hit Rate')
        plt.title('Cache Hit Rate')
        plt.legend()
        plt.savefig('cache_hit_rate.png')

def main():
    # load log file
    data_dir = sys.argv[1]
    processor = VarnishLogProcessor()
    processor.load_log(data_dir)
    processor.visualize_cache_hit()

if __name__ == '__main__':
    main()
