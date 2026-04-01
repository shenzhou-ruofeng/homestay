package com.ruoyi.common.config;

import com.github.benmanes.caffeine.cache.Caffeine;
import com.ruoyi.common.constant.Constants;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.caffeine.CaffeineCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

import java.util.Collections;
import java.util.concurrent.TimeUnit;

@Configuration
@EnableCaching
public class CacheConfig {

    @Value(value = "${user.password.lockTime}")
    private int lockTime;

    // 令牌有效期（默认30分钟）
    @Value("${token.expireTime}")
    private int expireTime;

    @Bean(name = "captchaCacheManager")
    public CacheManager captchaCacheManager() {
        CaffeineCacheManager cacheManager = new CaffeineCacheManager();
        cacheManager.setCaffeine(Caffeine.newBuilder()
                .expireAfterWrite(Constants.CAPTCHA_EXPIRATION, TimeUnit.MINUTES)
                .maximumSize(10000));  // 未指定缓存时的默认最大容量
        // 设置命名空间
        cacheManager.setCacheNames(Collections.singleton(Constants.LOCAL_CACHE_NAME));
        return cacheManager;
    }

    @Bean(name = "repeatSubmitCacheManager")
    public CacheManager repeatSubmitCacheManager() {
        CaffeineCacheManager cacheManager = new CaffeineCacheManager();
        cacheManager.setCaffeine(Caffeine.newBuilder()
                .expireAfterWrite(5000, TimeUnit.MILLISECONDS)
                .maximumSize(10000));  // 未指定缓存时的默认最大容量
        // 设置命名空间
        cacheManager.setCacheNames(Collections.singleton(Constants.LOCAL_CACHE_NAME));
        return cacheManager;
    }

    @Bean(name = "lockCacheManager")
    public CacheManager lockCacheManager() {
        CaffeineCacheManager cacheManager = new CaffeineCacheManager();
        cacheManager.setCaffeine(Caffeine.newBuilder()
                .expireAfterWrite(lockTime, TimeUnit.MINUTES)
                .maximumSize(10000));  // 未指定缓存时的默认最大容量
        // 设置命名空间
        cacheManager.setCacheNames(Collections.singleton(Constants.LOCAL_CACHE_NAME));
        return cacheManager;
    }

    @Bean(name = "tokenCacheManager")
    public CacheManager tokenCacheManager() {
        CaffeineCacheManager cacheManager = new CaffeineCacheManager();
        cacheManager.setCaffeine(Caffeine.newBuilder()
                .expireAfterWrite(expireTime, TimeUnit.MINUTES)
                .maximumSize(10000));  // 未指定缓存时的默认最大容量
        // 设置命名空间
        cacheManager.setCacheNames(Collections.singleton(Constants.LOCAL_CACHE_NAME));
        return cacheManager;
    }

    @Bean(name = "defaultCacheManager")
    @Primary
    public CacheManager defaultCacheManager() {
        CaffeineCacheManager cacheManager = new CaffeineCacheManager();
        cacheManager.setCaffeine(Caffeine.newBuilder()
                .maximumSize(10000));  // 未指定缓存时的默认最大容量
        // 设置命名空间
        cacheManager.setCacheNames(Collections.singleton(Constants.LOCAL_CACHE_NAME));
        return cacheManager;
    }


}