/// This class uses the standard Cache %Installer.Installer class to install existing cache.dat.
Class Util.Install
{

/// This is a main build manifest which create new build environment. See documentation for %Installer.Installer
/// on how to use build manifests.
XData BuildManifest [ XMLNamespace = INSTALLER ]
{
<Manifest>
<!-- You have to specify JOBNAME with job name via parameter string -->
<If Condition="&quot;${JOBNAME}&quot;=&quot;&quot;"><Error /></If>
<!-- You have to specify SRCDIR with source code directory via parameter string -->
<If Condition="&quot;${SRCDBDIR}&quot;=&quot;&quot;"><Error /></If>

<!-- Namespace -->
<Var Name="NAMESPACE" Value="${JOBNAME}" />

<!-- Now, dismount database so we can copy database file -->
<!-- This call is invoked in %SYS namespace -->
<Namespace Name="%SYS">
<Invoke Class="SYS.Database" Method="DismountDatabase" CheckStatus="false">
<Arg name="DatabaseDir" Value="${NAMESPACE}" />
</Invoke>
</Namespace>

<!-- Copy database file to new environment -->
<CopyDir Src="${SRCDBDIR}" Target="${MGRDIR}${NAMESPACE}" />

<!-- Now, mount database  -->
<Namespace Name="%SYS">
<Invoke Class="SYS.Database" Method="MountDatabase" CheckStatus="false">
<Arg name="DatabaseDir" Value="${NAMESPACE}" />
</Invoke>
</Namespace>


<!-- Delete old namespace and create new one -->
<Namespace Name="${NAMESPACE}" Create="overwrite" 
  Code="${NAMESPACE}" Data="${NAMESPACE}">
<Configuration>
<Database Name="${NAMESPACE}" Dir="${NAMESPACE}" Create="no" InitialSize="1" ExpansionSize="1" />
 <CSPApplication name="${NAMESPACE}" Directory="${MGRDIR}${NAMESPACE}\csp" Url="/csp/${NAMESPACE}"
  Description="Build application" 
  Recurse="true" 
  ServeFiles="true"
   AuthenticationMethods="64" />
<Invoke Class="%SYSTEM.OBJ" Method="Compile" CheckStatus="false">
<Arg name="ClassName" Value="ui.Template" />
</Invoke>
</Configuration>


</Namespace>

</Manifest>
}

/// This method is called to pass parameters into generated build method
ClassMethod Install(pJobName As %String = "VEGIE", pSrcDbDir As %String) As %Status
{
	set vars("JOBNAME")=$g(pJobName)
	set vars("SRCDBDIR")=##class(%File).NormalizeFilename($g(pSrcDbDir))

	Set pLogLevel=3
	Set sc=..RunBuildManifest(.vars, .pLogLevel)

	Quit sc
}

/// This method is called to set up source control
ClassMethod SetUpSourceControl(pSrcDir As %String = "C:\source\") As %Status
{
	set ^Sources=pSrcDir
	set ^Sources("CLS","*")="cls/"
	set ^Sources("CSP","*")="web/"
	set ^Sources("MAC","*")="rtn/"

	Quit $$$OK
}

/// This is a standard %Installer method generator whose code is generated by XGL.
ClassMethod RunBuildManifest(ByRef pVars, pLogLevel As %Integer, pInstaller As %Installer.Installer) As %Status [ CodeMode = objectgenerator, Internal ]
{
	#; Let our XGL document generate code for this method.
	quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "BuildManifest")
}

}