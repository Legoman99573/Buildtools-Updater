curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastBuild/artifact/target/BuildTools.jar
java -jar BuildTools.jar --rev latest
rm BuildTools.jar
curl -o BuildTools.sh https://raw.githubusercontent.com/NatoBoram/Buildtools-Updater/0.10.4-Beta/BuildTools.sh
exit
