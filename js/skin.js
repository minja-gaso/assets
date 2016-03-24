function createSkin()
{
  document.portal_form.ACTION.value = 'CREATE_SKIN';
  document.portal_form.SCREEN.value = 'GENERAL';
}
function saveSkin()
{
  document.portal_form.ACTION.value = 'SAVE_SKIN';
}
function saveAppCss()
{
  document.portal_form.ACTION.value = 'SAVE_APP_CSS';
}
function resetCss()
{
  document.portal_form.SKIN_CSS.value = '';
}
function skins()
{
  document.portal_form.SCREEN.value = 'LIST';
  document.portal_form.SKIN_ID.value = 0;
}
function createEvent()
{
  document.portal_form.ACTION.value = 'CREATE_EVENT';
  document.portal_form.SCREEN.value = 'EVENT';
}
function editEvent(id)
{
  document.portal_form.SCREEN.value = 'EVENT';
  document.portal_form.EVENT_ID.value = id;
}
function saveEvent()
{
  document.portal_form.ACTION.value = 'SAVE_EVENT';
}
function deleteEvent(id)
{
  document.portal_form.ACTION.value = 'DELETE_EVENT';
  document.portal_form.EVENT_ID.value = id;
}
function editSkin(id)
{
  document.portal_form.SCREEN.value = 'GENERAL';
  document.portal_form.SKIN_ID.value = id;
}
function deleteSkin(id)
{
  document.portal_form.ACTION.value = 'DELETE_SKIN';
  document.portal_form.SKIN_ID.value = id;
}
function deleteEventImage()
{
  document.portal_form.ACTION.value = 'DELETE_EVENT_IMAGE';
}
function addRole()
{
  document.portal_form.ACTION.value = 'ADD_ROLE';
}
function deleteRole(id)
{
  document.portal_form.ACTION.value = 'DELETE_ROLE';
  document.portal_form.ROLE_ID.value = id;
}
function addCategory()
{
  document.portal_form.ACTION.value = 'ADD_CATEGORY';
}
function deleteCategory(id)
{
  document.portal_form.ACTION.value = 'DELETE_CATEGORY';
  document.portal_form.CATEGORY_ID.value = id;
}
function eventListScreen()
{
  document.portal_form.SCREEN.value = 'EVENTS';
  document.portal_form.EVENT_ID.value = 0;
}
function toggleCheckboxes(self, name)
{
  var isChecked = false;
  if(self.checked)
  {
    isChecked = true;
  }
  var elements = document.getElementsByName(name);
  for(var index = 0; index < elements.length; index++)
  {
    var element = elements[index];
    element.checked = isChecked;
  }
}

$(".help").click(function(){
  $(".help-block").toggle();
})
