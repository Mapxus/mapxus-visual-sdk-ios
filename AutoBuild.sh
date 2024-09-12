#!/bin/sh

#  AutoRun.sh
#  MapxusVisualSDK
#
#  Created by chenghao guo on 2020/9/14.
#  Copyright © 2020 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.

############## 变量初始化 ##############

# 环境变量
ENV=""
# 机构变量
COM=""
# 编译配置文件
XCCONFIG_FILE='BuildConfig/mapxus.prod.xcconfig'
# 项目名
PROJECT_NAME='MapxusVisualSDK.xcworkspace'
# The scheme which to build
SCHEME='MapxusVisualSDK-Universal'
# 包名
FREAMEWORK_PACKAGE_NAME='MapxusVisualSDK.xcframework'
# 包原始路径
ORIGINAL_PATH='./Output/DynamicFramework'

## Always build global
# 分发根的上级目录，手动使用本工具打包时，可以不传-d参数，使用本默认值
GLOBAL_DISTRIBUTION_PARENT_PATH="${PWD}/.."
# 分发根目录
GLOBAL_DISTRIBUTION_ROOT_PATH="/mapxus-visual-sdk-ios"
# 分发目录下载源
GLOBAL_DISTRIBUTION_URL='https://github.com/Mapxus/mapxus-visual-sdk-ios.git'

## Maybe build region
# 分发根的上级目录，手动使用本工具打包时，可以不传-d参数，使用本默认值
REGION_DISTRIBUTION_PARENT_PATH="${PWD}/.."
# 分发根目录
REGION_DISTRIBUTION_ROOT_PATH="/mapxus-visual-sdk-ios"
# 分发目录下载源
REGION_DISTRIBUTION_URL='https://github.com/Mapxus/mapxus-visual-sdk-ios.git'
# 签发证书
CER_SHA_1='3237CC2300F47D6DF17367B086B164D21D7AB28B'


############## 参数获取 ##############

# c: 公司，可选mapxus、landsd、kawasaki
# d: framework文件存放根目录
# e: 环境，可选test、prod
while getopts ":c:d:e:" opt
do
    case $opt in
        d)
        GLOBAL_DISTRIBUTION_PARENT_PATH=$OPTARG
        ;;
        e)
        if [[ $OPTARG == "test" ]]; then
            ENV="-test"
        fi
        ;;
        c)
        if [[ $OPTARG == "landsd" ]]; then
            COM="-landsd"
        elif [[ $OPTARG == "kawasaki" ]]; then
            COM="-kawasaki"
        elif [[ $OPTARG == "stem" ]]; then
            COM="-stem"
        fi
        ;;
        ?)
        echo "未知参数"
        exit 1;;
    esac
done


############## 更新变量 ##############

#"https://web-sdk.mapxus.com/prod/mapxus-visual-1.7.1.css"
#"https://web-sdk.mapxus.com/prod/mapxus-visual-1.7.1.js"

#"https://web-sdk.mapxus.com/test/mapxus-visual-1.7.1.css"
#"https://web-sdk.mapxus.com/test/mapxus-visual-1.7.1.js"

CSS_URL=""
JS_URL=""

if [[ -z $COM ]] && [[ -z $ENV ]]; then
    CSS_URL="https:\/\/web-sdk.mapxus.com\/prod\/mapxus-visual-1.10.0.css"
    JS_URL="https:\/\/web-sdk.mapxus.com\/prod\/mapxus-visual-1.10.0.js"
    XCCONFIG_FILE='BuildConfig/mapxus.prod.xcconfig'

elif [[ -z $COM ]] && [[ $ENV == "-test" ]]; then
    CSS_URL="https:\/\/web-sdk.mapxus.com\/test\/mapxus-visual-1.10.0-beta.1.css"
    JS_URL="https:\/\/web-sdk.mapxus.com\/test\/mapxus-visual-1.10.0-beta.1.js"
    XCCONFIG_FILE='BuildConfig/mapxus.test.xcconfig'

elif [[ $COM == "-landsd" ]] && [[ -z $ENV ]]; then
    CSS_URL="https:\/\/web-sdk.mapxus.com\/prod\/mapxus-visual-1.8.1-landsd.css"
    JS_URL="https:\/\/web-sdk.mapxus.com\/prod\/mapxus-visual-1.8.1-landsd.js"
    XCCONFIG_FILE='BuildConfig/landsd.prod.xcconfig'
    
    REGION_DISTRIBUTION_PARENT_PATH="${GLOBAL_DISTRIBUTION_PARENT_PATH}/sdk-landsd"
    REGION_DISTRIBUTION_ROOT_PATH="/mapxus-visual-sdk-ios-landsd"
    REGION_DISTRIBUTION_URL='https://chenghaoguo@bitbucket.org/chenghaoguo/mapxus-visual-sdk-ios-landsd.git'

elif [[ $COM == "-landsd" ]] && [[ $ENV == "-test" ]]; then
    CSS_URL="https:\/\/web-sdk.mapxus.com\/test\/mapxus-visual-1.8.1-beta.1-landsd.css"
    JS_URL="https:\/\/web-sdk.mapxus.com\/test\/mapxus-visual-1.8.1-beta.1-landsd.js"
    XCCONFIG_FILE='BuildConfig/landsd.test.xcconfig'
    
elif [[ $COM == "-stem" ]]; then
    CSS_URL="https:\/\/web-sdk.mapxus.com\/prod\/mapxus-visual-1.10.0-stem.1.css"
    JS_URL="https:\/\/web-sdk.mapxus.com\/prod\/mapxus-visual-1.10.0-stem.1.js"
    XCCONFIG_FILE='BuildConfig/stem.prod.xcconfig'

elif [[ $COM == "-kawasaki" ]]; then
    CSS_URL="https:\/\/web-sdk.mapxus.co.jp\/prod\/mapxus-visual-1.10.0.css"
    JS_URL="https:\/\/web-sdk.mapxus.co.jp\/prod\/mapxus-visual-1.10.0.js"
    XCCONFIG_FILE='BuildConfig/kawasaki.prod.xcconfig'
    
    REGION_DISTRIBUTION_PARENT_PATH="${GLOBAL_DISTRIBUTION_PARENT_PATH}/sdk-jp"
    REGION_DISTRIBUTION_ROOT_PATH="/mapxus-visual-sdk-ios-jp"
    REGION_DISTRIBUTION_URL='https://github.com/Mapxus/mapxus-visual-sdk-ios-jp.git'

fi

#
Orgin='<link href=.*rel="stylesheet">'
New='<link href="'${CSS_URL}'" rel="stylesheet">'
#替换地址
sed -i '' "s/${Orgin}/${New}/g" MapxusVisualSDK/Resources/MXMVisualBrowse.html

#
Orgin='<script src=.* type="text\/javascript"><\/script>'
New='<script src="'${JS_URL}'" type="text\/javascript"><\/script>'
#替换地址
sed -i '' "s/${Orgin}/${New}/g" MapxusVisualSDK/Resources/MXMVisualBrowse.html


############## 编译 SDK 放在工程目录 ##############
## Generate the build number using current date and time
buildNumber=$(date "+%y.%m.%d.%H.%M")
## Set the build number in plist file
agvtool new-version "$buildNumber"

#打包并复制到目录
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

bundle exec pod install --repo-update
xcodebuild -workspace "${PROJECT_NAME}" -scheme "${SCHEME}" CER_SHA_1="${CER_SHA_1}" XCCONFIG_FILE="${XCCONFIG_FILE}"


function makeDirAndCopy {
    ############## 下载存放目录 ##############

    DISTRIBUTION_DIR="${1}${2}"
    echo "copy to ${DISTRIBUTION_DIR}"
    
    #目录如果不存在，则拉取github
    if [ ! -d "${DISTRIBUTION_DIR}" ]; then
        git clone "${3}" "${DISTRIBUTION_DIR}"
    fi

    DYNAMIC_DIR="${DISTRIBUTION_DIR}/dynamic"
    if [ ! -d "${DYNAMIC_DIR}" ]; then
        mkdir "${DYNAMIC_DIR}"
    fi

    ############## 包复制 ##############

    rm -rf "${DYNAMIC_DIR}/${FREAMEWORK_PACKAGE_NAME}"
    cp -rf "${ORIGINAL_PATH}/${FREAMEWORK_PACKAGE_NAME}" "${DYNAMIC_DIR}/${FREAMEWORK_PACKAGE_NAME}"
}


# copy to global
makeDirAndCopy ${GLOBAL_DISTRIBUTION_PARENT_PATH} ${GLOBAL_DISTRIBUTION_ROOT_PATH} ${GLOBAL_DISTRIBUTION_URL}

# copy to region
if [[ $GLOBAL_DISTRIBUTION_PARENT_PATH != $REGION_DISTRIBUTION_PARENT_PATH ]]; then
    makeDirAndCopy ${REGION_DISTRIBUTION_PARENT_PATH} ${REGION_DISTRIBUTION_ROOT_PATH} ${REGION_DISTRIBUTION_URL}
fi
