package miw.aspectj;

import java.util.HashMap;
import java.util.Map;

public aspect AspectCache {
	private Map<Integer, Integer> cache = new HashMap<Integer, Integer>();
	
	int around(int num): 
	call(int  Calculator.fibonacci(int)) && args(num) {
		
		Object valorEnCache = cache.get(new Integer(num));
		
		if(valorEnCache != null) {
			System.out.println("[CACHE] \tExito de cache [" + num + "] es: " + valorEnCache + ". La cache es:" + cache);
			return ((Integer)valorEnCache).intValue();
		}
		
		int value = proceed(num);
		try{
		insert(num, value);
		}catch (Exception e) {
			System.err.println("[CACHE] \tError al guardar en cache " + num + " con el valor " + value);
		}
		return value;
	}
	
	private void insert(Integer num, Integer value){
		cache.put(new Integer(num), new Integer(value));
	}
}
