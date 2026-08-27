{ pkgs, lib, ... }:
let
  jdk = pkgs.jdk17;

  abiVersion =
    if pkgs.stdenv.hostPlatform.isAarch64 then
      "arm64-v8a"
    else
      "x86_64";

  androidComposition = pkgs.androidenv.composeAndroidPackages {
    platformVersions = [ "36" ];
    buildToolsVersions = [ "35.0.0" ];
    includeEmulator = true;
    includeSystemImages = true;
    systemImageTypes = [ "google_apis" ];
    abiVersions = [ abiVersion ];
  };

  androidSdk = androidComposition.androidsdk;
  androidSdkRoot = "${androidSdk}/libexec/android-sdk";
  javaHome = "${jdk}/lib/openjdk";
in
{
  home.packages = [
    jdk
    pkgs.gradle_8
    androidSdk
  ];

  home.sessionVariables = {
    JAVA_HOME = javaHome;
    GRADLE_JAVA_HOME = javaHome;
    ANDROID_HOME = androidSdkRoot;
    ANDROID_SDK_ROOT = androidSdkRoot;
    ANDROID_USER_HOME = "$HOME/.android";
    ANDROID_AVD_HOME = "$HOME/.android/avd";
  };

  home.sessionPath = [
    "${androidSdkRoot}/cmdline-tools/latest/bin"
    "${androidSdkRoot}/emulator"
    "${androidSdkRoot}/platform-tools"
  ];
}
