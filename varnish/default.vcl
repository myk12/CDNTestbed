#
# This is an example VCL file for Varnish.
#
# It does not do anything by default, delegating control to the
# builtin VCL. The builtin VCL is called when there is no explicit
# return statement.
#
# See the VCL chapters in the Users Guide for a comprehensive documentation
# at https://www.varnish-cache.org/docs/.

# Marker to tell the VCL compiler that this VCL has been written with the
# 4.0 or 4.1 syntax.
vcl 4.0;

import std;

# Default backend definition. Set this to point to your content server.
backend default {
    .host = "128.105.144.110";
    .port = "6081";
}

sub vcl_recv {
    # 提取文件名并解析level值
    if (req.url ~ "^/(\d+)_([a-zA-Z0-9_-]+).dat$") {
        set req.http.level = regsub(req.url, "^/(\d+)_.*", "\1");
        if (req.http.level ~ "^[0-9]+$") {
            # 计算缓存时间字符串 (例: "30m" 表示30分钟)
            set req.http.cache_time_str = req.http.level + "0m";
        } else {
            set req.http.cache_time_str = "10m";  # 默认缓存时间
        }
    } else {
        set req.http.cache_time_str = "10m";  # 默认缓存时间
    }

    return (hash);
}

sub vcl_backend_response {
    # 设置缓存时间
    if (bereq.http.cache_time_str) {
        set beresp.ttl = std.duration(bereq.http.cache_time_str, 600s);  # 默认值10分钟
    } else {
        set beresp.ttl = 10m;  # 默认缓存时间
    }

    # 在响应头中添加调试信息，显示缓存时间
    set beresp.http.X-Cache-Time = beresp.ttl;
}

sub vcl_deliver {
    # 不再设置响应头，因为在这个上下文中不支持
}

