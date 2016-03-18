curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastBuild/artifact/target/BuildTools.jar
java -jar BuildTools.jar --rev latest
rm BuildTools.jar
exit