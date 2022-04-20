FROM thyrlian/android-sdk:latest

# Install dos2unix
RUN apt-get update && apt-get install -y dos2unix

# Build with gradlew kotlin
COPY . .
RUN chmod +x gradlew
RUN dos2unix ./gradlew
RUN ./gradlew clean assembleDebug

# get the .apk file
RUN cp app/build/outputs/apk/debug/app-debug.apk /SmartHears.apk
