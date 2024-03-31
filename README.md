
## Varnish使用指南

### 信息统计

**cache命中率**：`sudo varnishstat -1 | grep "cache`

```bash
MAIN.cache_hit                         5         0.01 Cache hits
MAIN.cache_hit_grace                   0         0.00 Cache grace hits
MAIN.cache_hitpass                     0         0.00 Cache hits for pass.
MAIN.cache_hitmiss                     0         0.00 Cache hits for miss.
MAIN.cache_miss                        4         0.01 Cache misses
MAIN.beresp_uncacheable                0         0.00 Uncacheable backend responses

```

`hit_ratio = cache_hit / (cache_hit + cache_miss) `
