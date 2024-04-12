-- Lua脚本用于添加自定义请求头

-- 在此处定义权重映射表，例如从URL到权重大小的映射
local weight_map = {
    ["/1KB.dat"] = 1,
    ["/10KB.dat"] = 10,
    ["/100KB.dat"] = 100,
    -- 添加更多对象的映射
}

-- 获取请求的URL
local url = ngx.var.uri

-- 检查映射表中是否存在对应的权重大小
local weight = weight_map[url]
if weight then
    -- 如果存在，则添加自定义请求头
    ngx.header["X-Object-Weight"] = weight
else
    ngx.header["X-Object-Weight"] = "1000"
end
