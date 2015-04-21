package com.cheng.pkeeper.util;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

import com.alibaba.fastjson.JSON;


public class JsonUtil {

	/**
	 * 将json体转换成String对象
	 */
	public static String toJSONString(Object object)
	{
		return JSON.toJSONString(object);
	}
	
	public static String toUriString(String object)
	{
		object = object.replace(",http:", "*@@@@*");
		object = object.replace("http:", "**@@**");
		object = object.replace(",", "&");
		object = object.replace(":", "=");
		object = object.replace("{", "");
		object = object.replace("}", "");
		object = object.replace("\"", "");
		object = object.replace("**@@**", "http:");
		object = object.replace("*@@@@*", ",http:");
		return object;
	}
	
	/**
	 * json数据转换成数据模型对象
	 */
	public static <T> T toJSONBean(String text,Class<T> clazz)
	{
		return JSON.parseObject(text,clazz);
	}
	
	/**
	 * 表一组有序的数值。将其转换为String数组输出
	 */
	public static <T> List<T> toJSONLisBean(String text, Class<T> clazz)
	{
		return JSON.parseArray(text, clazz);
	}
	
	/**
     * 将Javabean转换为Map
     * 
     * @param javaBean
     *            javaBean
     * @return Map对象
     */
    public static Map toMap(Object javaBean) {

        Map result = new HashMap();
        Method[] methods = javaBean.getClass().getDeclaredMethods();

        for (Method method : methods) {

            try {

                if (method.getName().startsWith("get")) {

                    String field = method.getName();
                    field = field.substring(field.indexOf("get") + 3);
                    field = field.toLowerCase().charAt(0) + field.substring(1);

                    Object value = method.invoke(javaBean, (Object[]) null);
                    result.put(field, null == value ? "" : value.toString());

                }

            } catch (Exception e) {
                e.printStackTrace();
            }

        }

        return result;

    }
	
	/**
     * 将Json对象转换成Map
     * 
     * @param jsonObject
     *            json对象
     * @return Map对象
     * @throws JSONException
     */
    public static Map toMap(String jsonString) throws JSONException {

        JSONObject jsonObject = new JSONObject(jsonString);
        
        Map result = new HashMap();
        Iterator iterator = jsonObject.keys();
        String key = null;
        String value = null;
        while (iterator.hasNext()) {

            key = (String) iterator.next();
            value = jsonObject.getString(key);
            result.put(key, value);

        }
        return result;

    }
    
    /**
     * 将Map转换成Javabean
     * 
     * @param javabean
     *            javaBean
     * @param data
     *            Map数据
     */
    public static Object toJavaBean(Object javabean, Map data) {

        Method[] methods = javabean.getClass().getDeclaredMethods();
        for (Method method : methods) {

            try {
                if (method.getName().startsWith("set")) {

                    String field = method.getName();
                    field = field.substring(field.indexOf("set") + 3);
                    field = field.toLowerCase().charAt(0) + field.substring(1);
                    method.invoke(javabean, new Object[] {

                    data.get(field)

                    });

                }
            } catch (Exception e) {
            }

        }

        return javabean;

    }


	
}
