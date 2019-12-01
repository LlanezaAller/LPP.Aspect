package miw.aspectj;

public aspect ObserverAspect extends ObserverProtocol {

	//	Roles played by the Calculator and the CalculatorUseOnScreen
	declare parents: Calculator implements Subject;
	declare parents: CalculatorUseOnScreen implements Observer;

	// Se incluye la propiedad calls dentro de la calculadora para trascender a la clase
	private int Calculator.calls = 0;

	/**
	 * Pointcut that catches any call to CalculatorUseOnScreen.observ()
	 */
	protected pointcut declareObserver(Calculator s, CalculatorUseOnScreen o):
		call(void CalculatorUseOnScreen.observ(*)) && args(s) && target(o);

	/**
	 * Advice that adds a new (autodeclared) observer
	 */
	after(Calculator s, CalculatorUseOnScreen o) : declareObserver(s, o) {
		addObserver((Subject)s, (Observer)o); }	

	/**
	 * Pointcut that catches any call to Calculator.fibonacci()
	 * */
	protected pointcut subjectChange(Subject subject):
		call(int Calculator.fibonacci(*)) && target(subject);
	

	/**
	* This method defines how observers are updated when a change in
	* the subject occurs. It is a concret implementation of the corresponding
	* method in the superaspect.
	*/
	protected void updateObserver(Subject subject, Observer observer) {
		Calculator cal = (Calculator) subject;
		CalculatorUseOnScreen cuos = (CalculatorUseOnScreen) observer;
		cuos.inform(cal.calls++);
	}
}
