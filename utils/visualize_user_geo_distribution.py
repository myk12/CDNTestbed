import pandas as pd
import geopandas as gpd
import folium

data_filename = "../user_fix.csv"

# 读取CSV文件
df = pd.read_csv(data_filename)

rows_to_sample = int(len(df)*0.01)
# 使用sample函数随机抽取数据
df_sampled = df.sample(n=rows_to_sample, random_state=42)

# 创建地图对象
map = folium.Map(location=[0, 0], zoom_start=2)

# 添加散点层
for index, row in df_sampled.iterrows():
    folium.CircleMarker(
        location=[row['lat'], row['lng']],
        radius=1,
        fill=True
    ).add_to(map)

# 保存地图
map.save('world_map.html')