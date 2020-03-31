//68行   width  height  修改过   原内容:var png = convertToPng(image,width，height)
function convertToPng(src, w, h) {
            var canvas = document.createElement('canvas');
            var context = canvas.getContext('2d');
            canvas.width = w;
            canvas.height = h;
            context.drawImage(src, 0, 0);
            var png;
            try {
                png = canvas.toDataURL();
            } catch (e) {
                if ((typeof SecurityError !== 'undefined' && e instanceof SecurityError) || e.name == "SecurityError") {
                    console.error("Rendered SVG images cannot be downloaded in this browser.");
                    return;
                } else {
                    throw e;
                }
            }
            return png;
}
 
function isElement(obj) {
    return obj instanceof HTMLElement || obj instanceof SVGElement;
}
 
function reEncode(data) {
    data = encodeURIComponent(data);
    data = data.replace(/%([0-9A-F]{2})/g, function (match, p1) {
        var c = String.fromCharCode('0x' + p1);
        return c === '%' ? '%25' : c;
    });
    return decodeURIComponent(data);
}
 
function uriToBlob(uri) {
    var byteString = window.atob(uri.split(',')[1]);
    var mimeString = uri.split(',')[0].split(':')[1].split(';')[0]
    var buffer = new ArrayBuffer(byteString.length);
    var intArray = new Uint8Array(buffer);
    for (var i = 0; i < byteString.length; i++) {
        intArray[i] = byteString.charCodeAt(i);
    }
    return new Blob([buffer], {type: mimeString});
}

function downLoad(el, name) {
    if (!isElement(el)) {
        throw new Error('an HTMLElement or SVGElement is required; got ' + el);
    }
    if (!name) {
        console.error("下载失败");
        return;
    }
    var xmlns = "http://www.w3.org/2000/xmlns/";
    var clone = el.cloneNode(true);
    clone.setAttribute("version", "1.1");
    if (!clone.getAttribute('xmlns')) {
        clone.setAttributeNS(xmlns, "xmlns", "http://www.w3.org/2000/svg");
    }
    if (!clone.getAttribute('xmlns:xlink')) {
        clone.setAttributeNS(xmlns, "xmlns:xlink", "http://www.w3.org/1999/xlink");
    }
    var svg = clone.outerHTML;
    console.log(svg);
    var uri = 'data:image/svg+xml;base64,' + window.btoa(reEncode(svg));
    var image = new Image();
    image.onload = function () {
        var png = convertToPng(image, width, height);
        var saveLink = document.createElement('a');
        var downloadSupported = 'download' in saveLink;
        if (downloadSupported) {
            saveLink.download = name + ".png";
            saveLink.style.display = 'none';
            document.body.appendChild(saveLink);
            try {
                var blob = uriToBlob(png);
                var url = URL.createObjectURL(blob);
                saveLink.href = url;
                saveLink.onclick = function () {
                    requestAnimationFrame(function () {
                        URL.revokeObjectURL(url);
                    })
                };
            } catch (e) {
                saveLink.href = uri;
            }
            saveLink.click();
            document.body.removeChild(saveLink);
        }
    };
    image.src = uri;
}