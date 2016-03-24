function generateTimeOptions(element, time)
{
  var START_TIME = 0;
  var END_TIME = 1440;
  var select = document.getElementById(element);
  var hours, minutes, ampm;
  for(var i = START_TIME; i < END_TIME; i = i + 15)
  {
      hours = Math.floor(i / 60);
      if (hours < 10)
      {
          hours = '0' + hours;
      }
      minutes = i % 60;
      if (minutes < 10)
      {
          minutes = '0' + minutes;
      }

      var value = hours + ':' + minutes + ':00';
      var label = '';
      if(hours < 12)
      {
        if(hours == '00')
        {
          hours = '12';
        }
        label += hours + ':' + minutes + ' a.m.';
      }
      else
      {
        var labelHour = hours;
        if(labelHour > 12)
        {
          labelHour = labelHour - 12;
        }
        label += labelHour + ':' + minutes + ' p.m.';
      }

      var optionEl = document.createElement('option');
      optionEl.setAttribute('value', value);
      if(time == value)
      {
        optionEl.setAttribute('selected', 'selected');
      }
      optionEl.innerHTML = label;
      select.appendChild(optionEl);
  }
}
