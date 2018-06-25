Class school.FrontPage Extends %CSP.Page
{

ClassMethod OnPage() As %Status
{
	&html<
	<html>
		<body>
			<h1> Привет! Это я, твое приложение! :) </h1>
			<p> $zv: #($zv)#
			<p> $zdt: #($zdt($h,4))#
			<p> (c) Sergei Shutov, InterSystems
		</body>
	</html> 
	>
	quit $$$OK
}

}
