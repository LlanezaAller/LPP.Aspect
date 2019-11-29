package miw.aspectj;

import java.util.Random;

public aspect AspectRandomExceptionCache {
	
	void around(Integer num, Integer value): call(void  AspectCache.insert(Integer, Integer)) && args(num, value){
		Random random=new Random();
		int aleatorio=random.nextInt(100);
		
		// 75% de fallo. Se aborta la ejecución con una excepción
		if(aleatorio < 75){
			throw new NullPointerException();
		}
		// 25% de éxito
		proceed(num,value);
	}
}
