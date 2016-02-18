var scripts = document.getElementsByTagName('script');
var thisScript = scripts[scripts.length - 1];
var content = document.createElement('div');
    content.id = 'sample-content';
    content.innerHTML = '<p>H\ello</p>\
    <p>Tops</p>';
thisScript.parentNode.insertBefore(content, thisScript.nextSibling);
