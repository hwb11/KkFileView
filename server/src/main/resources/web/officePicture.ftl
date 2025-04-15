<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>PDF图片预览</title>
    <#include "*/commonHeader.ftl">
    <script src="js/lazyload.js"></script>
    <style>
        body {
            background-color: #404040;
        }
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 100%;
            height: 100%;
        }
        .img-area {
            text-align: center;
        }
        .my-photo {
            max-width: 98%;
            margin:0 auto;
            border-radius:3px;
            box-shadow:rgba(0,0,0,0.15) 0 0 8px;
            background:#FBFBFB;
            border:1px solid #ddd;
            margin:1px auto;
            padding:5px;
        }

    </style>
</head>
<body>
<div class="container">
    <#list imgUrls as img>
        <div class="img-area" id="page-${img?index + 1}">
            <img class="my-photo" alt="loading"  data-src="${img}" src="images/loading.gif">
        </div>
    </#list>
</div>
<#if "false" == switchDisabled>
    <img src="images/pdf.svg" width="48" height="48" style="position: fixed; cursor: pointer; top: 40%; right: 48px; z-index: 999;" alt="使用PDF预览" title="使用PDF预览" onclick="changePreviewType('pdf')"/>
</#if>
<script>
    window.onload = function () {
        /*初始化水印*/
        initWaterMark();
        checkImgs();


    };
    // document.addEventListener('DOMContentLoaded', function () {
    //     const targetPage = getParameterByName('page');
    //     if (targetPage) {
    //         const elementId = `page-` + targetPage;
    //         console.log(elementId);
    //         const targetElement = document.getElementById(elementId);
    //         if (targetElement) {
    //             targetElement.style.position = 'sticky';
    //             targetElement.style.bottom = '0';
    //         }
    //     }
    // });
    function getParameterByName(name) {
        const url = window.location.href;
        name = name.replace(/[$$$$]/g, '\\$&');
        const regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)');
        const results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, ' '));
    }
    window.onscroll = throttle(checkImgs);
    function changePreviewType(previewType) {
        var url = window.location.href;
        if (url.indexOf("officePreviewType=image") !== -1) {
            url = url.replace("officePreviewType=image", "officePreviewType="+previewType);
        } else {
            url = url + "&officePreviewType="+previewType;
        }
        if ('allImages' === previewType) {
            window.open(url)
        } else {
            window.location.href = url;
        }
    }
    document.addEventListener('DOMContentLoaded', function () {
        const targetPage = getParameterByName('page');
        if (targetPage) {
            const elementId = `page-`+targetPage;
            const targetElement = document.getElementById(elementId);
            const imgElement = targetElement.querySelector('img');
            if (imgElement.complete) {
                // 图片已经加载完成，直接滚动
                targetElement.scrollIntoView({ behavior: 'smooth', block: 'end' });
            } else {
                // 等待图片加载完成
                imgElement.addEventListener('load', function() {
                    targetElement.scrollIntoView({ behavior: 'smooth', block: 'end' });
                });
            }
        }
    });
</script>
</body>
</html>
