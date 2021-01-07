#!/bin/sh

#  AutoRun.sh
#  MapxusVisualSDK
#
#  Created by chenghao guo on 2020/10/15.
#  Copyright © 2020 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.


#
ENV=""
#
COM=""
# 手动使用本工具打包时，可以不传-d参数，使用本默认值
FRAMEWORK_ROOT_PATH="${PWD}/.."

# c: 公司，可选mapxus、landsd
# d: framework文件存放根目录
# e: 环境，可选test、prod
while getopts ":c:d:e:" opt
do
    case $opt in
        d)
        FRAMEWORK_ROOT_PATH=$OPTARG
        ;;
        e)
        if [ $OPTARG == "test" ]
        then
            ENV="test"
        fi
        ;;
        c)
        if [ $OPTARG == "landsd" ]
        then
            COM="landsd"
        fi
        ;;
        ?)
        echo "未知参数"
        exit 1;;
    esac
done


#"https://web-sdk.mapxus.com/prod/mapxus-visual-1.7.1.css"
#"https://web-sdk.mapxus.com/prod/mapxus-visual-1.7.1.js"

#"https://web-sdk.mapxus.com/test/mapxus-visual-1.7.1.css"
#"https://web-sdk.mapxus.com/test/mapxus-visual-1.7.1.js"

CSS_URL=""
JS_URL=""

if [[ -z $COM ]] && [[ -z $ENV ]]; then
    CSS_URL="https:\/\/web-sdk.mapxus.com\/prod\/mapxus-visual-1.7.1.css"
    JS_URL="https:\/\/web-sdk.mapxus.com\/prod\/mapxus-visual-1.7.1.js"
    
elif [[ -z $COM ]] && [[ $ENV == "test" ]]; then
    CSS_URL="https:\/\/web-sdk.mapxus.com\/test\/mapxus-visual-1.7.1.css"
    JS_URL="https:\/\/web-sdk.mapxus.com\/test\/mapxus-visual-1.7.1.js"
    
elif [[ $COM == "landsd" ]] && [[ -z $ENV ]]; then
    CSS_URL="https:\/\/web-sdk.mapxus.com\/prod\/mapxus-visual-1.8.0-landsd.css"
    JS_URL="https:\/\/web-sdk.mapxus.com\/prod\/mapxus-visual-1.8.0-landsd.js"

elif [[ $COM == "landsd" ]] && [[ $ENV == "test" ]]; then
    CSS_URL="https:\/\/web-sdk.mapxus.com\/test\/mapxus-visual-1.7.1-beta.3-landsd.css"
    JS_URL="https:\/\/web-sdk.mapxus.com\/test\/mapxus-visual-1.7.1-beta.3-landsd.js"

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

FRAMEWORK_DIR="$FRAMEWORK_ROOT_PATH/mapxus-visual-sdk-ios-template/dynamic"
#目录如果不存在，则拉取github
if [ ! -d "${FRAMEWORK_DIR}" ]
then
  git clone git@gitee.com:150vb/mapxus-visual-sdk-ios-template.git "$FRAMEWORK_ROOT_PATH/mapxus-visual-sdk-ios-template"
fi

#打包并复制到目录
pod install
xcodebuild -workspace MapxusVisualSDK.xcworkspace -scheme MapxusVisualSDK-Universal POD_DIR="$FRAMEWORK_DIR"

