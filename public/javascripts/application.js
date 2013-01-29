//element_ids: 需要清除value的页面元素id值，是一个id数组
function clear_element_value(element_ids) {
    for(var i=0;i<element_ids.length;i++) {
        $(element_ids[i]).value = '';
    }
}

function showTab(name) {
  var f = $$('div.tab-content');
  for(var i=0; i<f.length; i++){
    Element.hide(f[i]);
  }
  var f = $$('div.tabs a');
  for(var i=0; i<f.length; i++){
    Element.removeClassName(f[i], "selected");
  }
  Element.show('tab-content-' + name);
  Element.addClassName('tab-' + name, "selected");
  return false;
}

function show_list(name) {
  if(name == 'dailynote') {
      Element.show('dailynotes_list');
      Element.hide('weeklynotes_list');
  } else if(name == 'weeklynote') {
      Element.show('weeklynotes_list');
      Element.hide('dailynotes_list');
  }
}