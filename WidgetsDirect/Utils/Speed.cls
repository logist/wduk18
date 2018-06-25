Class Utils.Speed
{

/// do ##class(Utils.Speed).SumTest()
ClassMethod SumTest(limit = 10000000)
{
	// Запомним время старта
	set zh = $zh
	// Установим sum=0
	set sum = 0
	// for loop execution
	for a=0:1:limit-1 {
	        set sum = sum + a
	}
	// Вычислим время работы цикла
	set tDiff = $zh - zh

	// Выведем результаты на stdout
	write "Limit = ", limit, !
	write "Sum =   ", sum, !
	write "Time =  ", tDiff, !
}

}
