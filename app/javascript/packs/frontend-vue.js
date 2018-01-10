import Vue from 'vue/dist/vue.min.js'
import BootstrapVue from 'bootstrap-vue/dist/bootstrap-vue.min.js'
import ProgressiveImage from 'progressive-image/dist/vue.js'
import WritePost from '../components/WritePost.vue'
import Profile from '../components/Profile.vue'
//import App from '../components/App.vue'
//Vue.use(BootstrapVue);

document.addEventListener('DOMContentLoaded', () => {
  //document.body.appendChild(document.createElement('hello'))

  //write post render to post controller
  Vue.component('writepost', WritePost);
  var writepost = new Vue({
    el: '#write-post',
    render: h => h(WritePost)
  })

  //profile end user :render
  Vue.component('profile', Profile);
  var profile = new Vue({
    el: '#prof',
    render: h => h(Profile)
  })

  Vue.component('profile', {
    template: '#profile',
    props:{
      profile: Object
    }
  })

  var profile = new Vue({
    el: '#profile',
    data:{
      profile: []
    },
    mounted: function(){
      var li;
      li = this;
      $.ajax({
        url: '/users/{id}.json',
        success: function(res){
          li.profile = res;
        }
      })
    }
  })
  //posts list
  Vue.component('post-list', {
    template: '#post-list',
    props:{
      post: Object
    }
  })

  var posts = new Vue({
    el: '#posts',
    data:{
      posts: []
    },
    mounted: function(){
      var list;
      list = this;
      $.ajax({
        url: '/users/{id}/posts.json',
        success: function(res){
          list.posts = res;
        }
      })
    }
  });

  //user lists
  Vue.component('users-row', {
    template: '#users-row',
    props:{
      user: Object
    }
  })

  var users = new Vue({
    el: '#users',
    data:{
      users: []
    },
    mounted: function(){
      var that;
      that = this;
      $.ajax({
        url: '/users.json',
        success: function(res){
          that.users = res;
        }
      });
    }
  });
})
