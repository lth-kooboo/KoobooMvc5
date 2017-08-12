call clear.bat

cd..

call update_version.vbs

cd Publish

nuget.exe restore ..\Kooboo.CMS-Release.sln

".\MSBuild\15.0\Bin\MsBuild.exe" ..\Kooboo.CMS-Release.sln /t:rebuild /l:FileLogger,Microsoft.Build.Engine;logfile=Publish.log; /p:VisualStudioVersion=15.0

".\MSBuild\15.0\Bin\MsBuild.exe" ..\Kooboo.CMS.Web\Kooboo.CMS.Web.csproj /t:ResolveReferences;Compile /t:_CopyWebApplication /p:Configuration=Release /p:WebProjectOutputDir=..\Publish\Web /p:OutputPath=..\Publish\Web\Bin /p:VisualStudioVersion=15.0

".\MSBuild\15.0\Bin\MsBuild.exe" ..\Kooboo.CMS.Content\Kooboo.CMS.Content.FileServer.sln /t:rebuild /l:FileLogger,Microsoft.Build.Engine;logfile=Publish_FileServer.log; /p:VisualStudioVersion=15.0

".\MSBuild\15.0\Bin\MsBuild.exe" ..\Kooboo.CMS.Content\Kooboo.CMS.Content.FileServer.Web\Kooboo.CMS.Content.FileServer.Web.csproj /p:VisualStudioVersion=15.0 /p:DeployOnBuild=true /p:PublishProfile=FileServer.Web.pubxml

call copy.bat

call zip.bat