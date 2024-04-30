#!/bin/python3

import os
import sys
import re
import pandas as pd
import matplotlib.pyplot as plt

class VarnishLogProcessor:
    def __init__(self):
        self.log = []
        self.log_file = ''
        self.log_dir = ''
        self.client_request_list = []
        self.cache_hit_list = []
        self.record_time_list = []
    
    def load_log(self, log_file):
        self.log_file = log_file
        with open(log_file, 'r') as f:
            self.log = f.readlines()

            # parse log
            for line in self.log:
                if "[new epoch]" in line:
                    self.record_time_list.append(line[1:32])
                elif line.split()[0] == "MAIN.client_req":
                    self.client_request_list.append(line.split()[1])
                elif line.split()[0] == "MAIN.cache_hit":
                    self.cache_hit_list.append(line.split()[1])
    def visualize_cache_hit(self):
        df = pd.DataFrame({'sample_time': self.record_time_list, 'client_request': self.client_request_list, 'cache_hit': self.cache_hit_list})
        print(df)

        # calculate the cache hit rate and save to png file
        df['cache_hit_rate'] = df['cache_hit'].astype(int) / df['client_request'].astype(int)
        df['sample_time'] = pd.to_datetime(df['sample_time'])
        df.set_index('sample_time', inplace=True)
        
        plt.figure()
        df['cache_hit_rate'].plot()
        plt.title('Cache hit rate')
        plt.xlabel('Time')
        plt.ylabel('Cache hit rate')
        plt.savefig(self.log_file + '.png')
        print(df)

def main():
    # load log file
    log_file = sys.argv[1]
    processor = VarnishLogProcessor()
    processor.load_log(log_file)
    processor.visualize_cache_hit()

if __name__ == '__main__':
    main()
