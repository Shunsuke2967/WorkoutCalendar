window.addEventListener('DOMContentLoaded', function(){
  window.addEventListener('resize', function(){
    console.log("Width:" + window.innerWidth);
    console.log(parseInt(this.window.innerWidth));
    if(parseInt(this.window.innerWidth) < 500){
      document.getElementById('iphone').classList.remove('none');
      document.getElementById('pc').classList.add('none');
    }
    if(parseInt(this.window.innerWidth) > 500){
      document.getElementById('iphone').classList.add('none');
      document.getElementById('pc').classList.remove('none');
    }
  });
});

window.onload = function(){
  if(parseInt(this.window.innerWidth) < 500){
    document.getElementById('iphone').classList.remove('none');
    document.getElementById('pc').classList.add('none');
  }
  if(parseInt(this.window.innerWidth) > 500){
    document.getElementById('iphone').classList.add('none');
    document.getElementById('pc').classList.remove('none');
  }
  };

  document.getElementsByTagName('a').onclick = function() {
    if(parseInt(this.window.innerWidth) < 500){
      document.getElementById('iphone').classList.remove('none');
      document.getElementById('pc').classList.add('none');
    }
    if(parseInt(this.window.innerWidth) > 500){
      document.getElementById('iphone').classList.add('none');
      document.getElementById('pc').classList.remove('none');
    }
  };