package com.ruoyi.common.core.redis;

import java.util.*;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.constant.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.caffeine.CaffeineCache;
import org.springframework.cache.caffeine.CaffeineCacheManager;
import org.springframework.data.redis.core.BoundSetOperations;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Component;

/**
 * spring redis 工具类
 *
 * @author ruoyi
 **/
@SuppressWarnings(value = {"unchecked", "rawtypes"})
@Component
public class RedisCache {
    /**
     * 去掉Redis，改为本地缓存-hxx
     */
//    @Autowired
//    public RedisTemplate redisTemplate;

    private final CacheManager captchaCacheManager;
    private final CacheManager repeatSubmitCacheManager;
    private final CacheManager lockCacheManager;
    private final CacheManager tokenCacheManager;
    private final CacheManager defaultCacheManager;

    public RedisCache(
            @Qualifier("captchaCacheManager") CacheManager captchaCacheManager,
            @Qualifier("repeatSubmitCacheManager") CacheManager repeatSubmitCacheManager,
            @Qualifier("lockCacheManager") CacheManager lockCacheManager,
            @Qualifier("tokenCacheManager") CacheManager tokenCacheManager,
            @Qualifier("defaultCacheManager") CacheManager defaultCacheManager) {
        this.captchaCacheManager = captchaCacheManager;
        this.repeatSubmitCacheManager = repeatSubmitCacheManager;
        this.lockCacheManager = lockCacheManager;
        this.tokenCacheManager = tokenCacheManager;
        this.defaultCacheManager = defaultCacheManager;
    }

    /**
     * 缓存基本的对象，Integer、String、实体类等
     *
     * @param key   缓存的键值
     * @param value 缓存的值
     */
    public <T> void setCacheObject(final String key, final T value) {
//        redisTemplate.opsForValue().set(key, value);
        Cache cache = defaultCacheManager.getCache(Constants.LOCAL_CACHE_NAME);
        cache.put(key, value);
    }

//    /**
//     * 缓存基本的对象，Integer、String、实体类等
//     *
//     * @param key      缓存的键值
//     * @param value    缓存的值
//     * @param timeout  时间
//     * @param timeUnit 时间颗粒度
//     */
//    public <T> void setCacheObject(final String key, final T value, final Integer timeout, final TimeUnit timeUnit) {
//        redisTemplate.opsForValue().set(key, value, timeout, timeUnit);
//    }

    public <T> void setCacheObject(final String key, final T value, String cacheManager) {
        CacheManager chooseCacheManager;
        if (Constants.CAPTCHA_CACHE_MANAGER.equals(cacheManager)) {
            chooseCacheManager = captchaCacheManager;
        } else if (Constants.REPEAT_SUBMIT_CACHE_MANAGER.equals(cacheManager)) {
            chooseCacheManager = repeatSubmitCacheManager;
        } else if (Constants.LOCK_CACHE_MANAGER.equals(cacheManager)) {
            chooseCacheManager = lockCacheManager;
        } else if (Constants.TOKEN_CACHE_MANAGER.equals(cacheManager)) {
            chooseCacheManager = tokenCacheManager;
        } else {
            return;
        }
        Cache cache = chooseCacheManager.getCache(Constants.LOCAL_CACHE_NAME);
        cache.put(key, value);
    }


    /**
     * 设置有效时间
     *
     * @param key     Redis键
     * @param timeout 超时时间
     * @return true=设置成功；false=设置失败
     */
//    public boolean expire(final String key, final long timeout) {
//        return expire(key, timeout, TimeUnit.SECONDS);
//    }

    /**
     * 设置有效时间
     *
     * @param key     Redis键
     * @param timeout 超时时间
     * @param unit    时间单位
     * @return true=设置成功；false=设置失败
     */
//    public boolean expire(final String key, final long timeout, final TimeUnit unit) {
//        return redisTemplate.expire(key, timeout, unit);
//    }

    /**
     * 获取有效时间
     *
     * @param key Redis键
     * @return 有效时间
     */
//    public long getExpire(final String key) {
//        return redisTemplate.getExpire(key);
//    }

    /**
     * 判断 key是否存在
     *
     * @param key 键
     * @return true 存在 false不存在
     */
//    public Boolean hasKey(String key) {
//        return redisTemplate.hasKey(key);
//    }
    public Boolean hasKey(String key) {
        //原redis的缓存key不会重复，改为本地缓存由于缓存时间不同，是由不同的缓存管理器管理，为了不改动引用该方法的代码，只能一一判断
        Cache.ValueWrapper defaultCache = defaultCacheManager.getCache(Constants.LOCAL_CACHE_NAME).get(key);
        if (defaultCache != null) {
            return true;
        }
        Cache.ValueWrapper captcha = captchaCacheManager.getCache(Constants.LOCAL_CACHE_NAME).get(key);
        if (captcha != null) {
            return true;
        }
        Cache.ValueWrapper repeat = repeatSubmitCacheManager.getCache(Constants.LOCAL_CACHE_NAME).get(key);
        if (repeat != null) {
            return true;
        }
        Cache.ValueWrapper lock = lockCacheManager.getCache(Constants.LOCAL_CACHE_NAME).get(key);
        if (lock != null) {
            return true;
        }
        Cache.ValueWrapper token = tokenCacheManager.getCache(Constants.LOCAL_CACHE_NAME).get(key);
        if (token != null) {
            return true;
        }
        return false;
    }

    /**
     * 获得缓存的基本对象。
     *
     * @param key 缓存键值
     * @return 缓存键值对应的数据
     */
    public <T> T getCacheObject(final String key) {
//        ValueOperations<String, T> operation = redisTemplate.opsForValue();
        //        return operation.get(key);
        //原redis的缓存key不会重复，改为本地缓存由于缓存时间不同，是由不同的缓存管理器管理，为了不改动引用该方法的代码，只能一一判断
        Cache.ValueWrapper defaultCache = defaultCacheManager.getCache(Constants.LOCAL_CACHE_NAME).get(key);
        if (defaultCache != null) {
            return (T) defaultCache.get();
        }
        Cache.ValueWrapper captcha = captchaCacheManager.getCache(Constants.LOCAL_CACHE_NAME).get(key);
        if (captcha != null) {
            return (T) captcha.get();
        }
        Cache.ValueWrapper repeat = repeatSubmitCacheManager.getCache(Constants.LOCAL_CACHE_NAME).get(key);
        if (repeat != null) {
            return (T) repeat.get();
        }
        Cache.ValueWrapper lock = lockCacheManager.getCache(Constants.LOCAL_CACHE_NAME).get(key);
        if (lock != null) {
            return (T) lock.get();
        }
        Cache.ValueWrapper token = tokenCacheManager.getCache(Constants.LOCAL_CACHE_NAME).get(key);
        if (token != null) {
            return (T) token.get();
        }
        return null;
    }

    /**
     * 删除单个对象
     *
     * @param key
     */
    public boolean deleteObject(final String key) {
//        return redisTemplate.delete(key);
        //原redis的缓存key不会重复，改为本地缓存由于缓存时间不同，是由不同的缓存管理器管理，为了不改动引用该方法的代码，只能一一判断
        if (captchaCacheManager.getCache(Constants.LOCAL_CACHE_NAME).evictIfPresent(key) ||
                repeatSubmitCacheManager.getCache(Constants.LOCAL_CACHE_NAME).evictIfPresent(key) ||
                lockCacheManager.getCache(Constants.LOCAL_CACHE_NAME).evictIfPresent(key) ||
                tokenCacheManager.getCache(Constants.LOCAL_CACHE_NAME).evictIfPresent(key) ||
                defaultCacheManager.getCache(Constants.LOCAL_CACHE_NAME).evictIfPresent(key)
        ) {
            return true;
        }
        return false;
    }

    /**
     * 删除集合对象
     *
     * @param collection 多个对象
     * @return
     */
    public boolean deleteObject(final Collection collection) {
//        return redisTemplate.delete(collection) > 0;
        //原redis的缓存key不会重复，改为本地缓存由于缓存时间不同，是由不同的缓存管理器管理，为了不改动引用该方法的代码，只能一一判断
        int count = 0;
        for (Object key : collection) {
            if (captchaCacheManager.getCache(Constants.LOCAL_CACHE_NAME).evictIfPresent(key) ||
                    repeatSubmitCacheManager.getCache(Constants.LOCAL_CACHE_NAME).evictIfPresent(key) ||
                    lockCacheManager.getCache(Constants.LOCAL_CACHE_NAME).evictIfPresent(key) ||
                    tokenCacheManager.getCache(Constants.LOCAL_CACHE_NAME).evictIfPresent(key) ||
                    defaultCacheManager.getCache(Constants.LOCAL_CACHE_NAME).evictIfPresent(key)
            ) {
                count++;
            }
        }
        return count > 0;
    }

    /**
     * 缓存List数据
     *
     * @param key      缓存的键值
     * @param dataList 待缓存的List数据
     * @return 缓存的对象
     */
//    public <T> long setCacheList(final String key, final List<T> dataList) {
//        Long count = redisTemplate.opsForList().rightPushAll(key, dataList);
//        return count == null ? 0 : count;
//    }

    /**
     * 获得缓存的list对象
     *
     * @param key 缓存的键值
     * @return 缓存键值对应的数据
     */
//    public <T> List<T> getCacheList(final String key) {
//        return redisTemplate.opsForList().range(key, 0, -1);
//    }

    /**
     * 缓存Set
     *
     * @param key     缓存键值
     * @param dataSet 缓存的数据
     * @return 缓存数据的对象
     */
//    public <T> BoundSetOperations<String, T> setCacheSet(final String key, final Set<T> dataSet) {
//        BoundSetOperations<String, T> setOperation = redisTemplate.boundSetOps(key);
//        Iterator<T> it = dataSet.iterator();
//        while (it.hasNext()) {
//            setOperation.add(it.next());
//        }
//        return setOperation;
//    }

    /**
     * 获得缓存的set
     *
     * @param key
     * @return
     */
//    public <T> Set<T> getCacheSet(final String key) {
//        return redisTemplate.opsForSet().members(key);
//    }

    /**
     * 缓存Map
     *
     * @param key
     * @param dataMap
     */
//    public <T> void setCacheMap(final String key, final Map<String, T> dataMap) {
//        if (dataMap != null) {
//            redisTemplate.opsForHash().putAll(key, dataMap);
//        }
//    }

    /**
     * 获得缓存的Map
     *
     * @param key
     * @return
     */
//    public <T> Map<String, T> getCacheMap(final String key) {
//        return redisTemplate.opsForHash().entries(key);
//    }

    /**
     * 往Hash中存入数据
     *
     * @param key   Redis键
     * @param hKey  Hash键
     * @param value 值
     */
//    public <T> void setCacheMapValue(final String key, final String hKey, final T value) {
//        redisTemplate.opsForHash().put(key, hKey, value);
//    }

    /**
     * 获取Hash中的数据
     *
     * @param key  Redis键
     * @param hKey Hash键
     * @return Hash中的对象
     */
//    public <T> T getCacheMapValue(final String key, final String hKey) {
//        HashOperations<String, String, T> opsForHash = redisTemplate.opsForHash();
//        return opsForHash.get(key, hKey);
//    }

    /**
     * 获取多个Hash中的数据
     *
     * @param key   Redis键
     * @param hKeys Hash键集合
     * @return Hash对象集合
     */
//    public <T> List<T> getMultiCacheMapValue(final String key, final Collection<Object> hKeys) {
//        return redisTemplate.opsForHash().multiGet(key, hKeys);
//    }

    /**
     * 删除Hash中的某条数据
     *
     * @param key  Redis键
     * @param hKey Hash键
     * @return 是否成功
     */
//    public boolean deleteCacheMapValue(final String key, final String hKey) {
//        return redisTemplate.opsForHash().delete(key, hKey) > 0;
//    }

    /**
     * 获得缓存的基本对象列表
     *
     * @param pattern 字符串前缀
     * @return 对象列表
     */
    public Collection<String> keys(final String pattern) {
//        return redisTemplate.keys(pattern);
        //原redis的缓存key不会重复，改为本地缓存由于缓存时间不同，是由不同的缓存管理器管理，为了不改动引用该方法的代码，只能一一判断
        List<String> list = new ArrayList<>();
        ConcurrentMap<String,Object> captcha = ((com.github.benmanes.caffeine.cache.Cache) (captchaCacheManager.getCache(Constants.LOCAL_CACHE_NAME).getNativeCache())).asMap();
        list.addAll(captcha.keySet().stream().filter(name -> name.startsWith(pattern.replace("*", "")))
                .collect(Collectors.toList()));
        ConcurrentMap<String, Object> repeatSubmit = ((com.github.benmanes.caffeine.cache.Cache) (repeatSubmitCacheManager.getCache(Constants.LOCAL_CACHE_NAME).getNativeCache())).asMap();
        list.addAll(repeatSubmit.keySet().stream().filter(name -> name.startsWith(pattern.replace("*", "")))
                .collect(Collectors.toList()));
        ConcurrentMap<String, Object> lock = ((com.github.benmanes.caffeine.cache.Cache) (lockCacheManager.getCache(Constants.LOCAL_CACHE_NAME).getNativeCache())).asMap();
        list.addAll(lock.keySet().stream().filter(name -> name.startsWith(pattern.replace("*", "")))
                .collect(Collectors.toList()));
        ConcurrentMap<String, Object> token = ((com.github.benmanes.caffeine.cache.Cache) (tokenCacheManager.getCache(Constants.LOCAL_CACHE_NAME).getNativeCache())).asMap();
        list.addAll(token.keySet().stream().filter(name -> name.startsWith(pattern.replace("*", "")))
                .collect(Collectors.toList()));
        ConcurrentMap<String, Object> defaultMap = ((com.github.benmanes.caffeine.cache.Cache) (defaultCacheManager.getCache(Constants.LOCAL_CACHE_NAME).getNativeCache())).asMap();
        list.addAll(defaultMap.keySet().stream().filter(name -> name.startsWith(pattern.replace("*", "")))
                .collect(Collectors.toList()));
        return list;
    }
}
