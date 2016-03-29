function createBlog()
{
  document.portal_form.ACTION.value = 'CREATE_BLOG';
}
function saveBlog()
{
  document.portal_form.ACTION.value = 'SAVE_BLOG';
}
function blogs()
{
  document.portal_form.SCREEN.value = 'LIST';
  document.portal_form.BLOG_ID.value = 0;
}
function createTopic()
{
  document.portal_form.ACTION.value = 'CREATE_TOPIC';
  document.portal_form.SCREEN.value = 'TOPIC';
}
function topics()
{
  document.portal_form.SCREEN.value = 'TOPICS';
  document.portal_form.TOPIC_ID.value = 0;
}
function editTopic(id)
{
  document.portal_form.SCREEN.value = 'TOPIC';
  document.portal_form.TOPIC_ID.value = id;
}
function saveTopic()
{
  document.portal_form.ACTION.value = 'SAVE_TOPIC';
}
function deleteTopic(id)
{
  document.portal_form.ACTION.value = 'DELETE_TOPIC';
  document.portal_form.TOPIC_ID.value = id;
}
function editBlog(id)
{
  if(document.portal_form.COMPONENT_ID.value == 6)
  {
    document.portal_form.SCREEN.value = 'GENERAL';
  }
  else if(document.portal_form.COMPONENT_ID.value == 7)
  {
    document.portal_form.SCREEN.value = 'TOPICS';
  }
  document.portal_form.BLOG_ID.value = id;
}
function deleteBlog(id)
{
  document.portal_form.ACTION.value = 'DELETE_BLOG';
  document.portal_form.BLOG_ID.value = id;
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
