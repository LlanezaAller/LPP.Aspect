package miw.aspectj;

import java.util.HashMap;
import java.util.Map;

public aspect AspectCache {
	private Map<Integer, Integer> cache = new HashMap<Integer, Integer>();
	
	int around(int num): 
	call(int  Calculator.fibonacci(int)) && args(num) {
		
		// Se obtiene el valor de la caché
		Object valorEnCache = cache.get(new Integer(num));
		
		// En caso de que exista se retorna como un éxito en la caché
		if(valorEnCache != null) {
			System.out.println("\t\tExito de cache [" + num + "] es: " + valorEnCache + ". La cache es:" + cache);
			return ((Integer)valorEnCache).intValue();
		}
		
		// Como la caché ha fallado, se calcula el valor
		int value = proceed(num);
		try{
			// Se intenta incluir el valor calculado en la caché
			insert(num, value);
		}catch (Exception e) {
			System.err.println("\t\tError al guardar en cache " + num + " con el valor " + value);
		}
		return value;
	}
	
	private void insert(Integer num, Integer value){
		cache.put(new Integer(num), new Integer(value));
	}
}
