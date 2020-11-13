def rochester_cleaner_main():
  import geopandas as gpd
  import altair as alt
  import numpy as np
  import pandas as pd
  df=gpd.read_file('Data/animus.shp')
  df=df.sort_values(by=['dma_1'])
  df.iloc[160, df.columns.get_loc('dma_1')] = 'Rochester, NY'
  df.iloc[161, df.columns.get_loc('dma_1')] = "Rochester, MN-Mason City, IA-Austin, MN"
  mean_animus=np.mean(df['animus'])
  df['animus_difference']=((mean_animus-df['animus'])/df['animus'])*100
  df.to_file('Data/cleaned.shp')
