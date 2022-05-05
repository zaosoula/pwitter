<script lang="ts" setup>
import type { UserFull } from '~/models';

import { useContext } from '@nuxtjs/composition-api';
import { useProfilePicture } from '~/hooks/profilePicture';

const props = defineProps<{
  user: UserFull
}>();

const emit = defineEmits(['follow', 'unfollow']);

const { $axios, $auth } = useContext();

const isLoggedUser = props.user.id == $auth.user?.id;

const onFollowToggle = async () => {
  props.user.is_following ? await $axios.delete(`/users/${props.user.username}/follow`) : await $axios.post(`/users/${props.user.username}/follow`);
  props.user.is_following = !props.user.is_following;
  props.user.followers = props.user.is_following ? props.user.followers + 1 : props.user.followers -1;

  props.user.is_following ? emit('follow') : emit('unfollow');
};
</script>

<template>
  <div v-if="user">
    <section>
      <div class="feature-photo">
        <figure><img src="https://source.unsplash.com/random/1000x333/?abstract,color" class="featured-photo" alt=""></figure>
        <div class="add-btn">
          <span>{{ user.followers }} followers</span>
          <a v-if="!isLoggedUser" @click.prevent="onFollowToggle" href="#">{{ user.is_following ? 'Unfollow' : 'Follow' }}</a>
        </div>
        <!-- <form class="edit-phto">
          <i class="fa fa-camera-retro"></i>
          <label class="fileContainer">
            Edit Cover Photo
          <input type="file"/>
          </label>
        </form> -->
        <div class="container-fluid">
          <div class="row merged">
            <div class="col-lg-2 col-sm-3">
              <div class="user-avatar">
                <figure>
                  <img :src="useProfilePicture(user)" alt="">
                  <!-- <form class="edit-phto">
                    <i class="fa fa-camera-retro"></i>
                    <label class="fileContainer">
                      Edit Display Photo
                      <input type="file"/>
                    </label>
                  </form> -->
                </figure>
              </div>
            </div>
            <div class="col-lg-10 col-sm-9">
              <div class="timeline-info">
                <ul>
                  <li class="admin-name">
                    <h5>{{ user.username }}</h5>
                  </li>
                  <li>
                    <nuxt-link :to="`/user/${user.username}`">Posts</nuxt-link>
                    <!-- <a class="" href="timeline-photos.html" title="" data-ripple="">Photos</a>
                    <a class="" href="timeline-videos.html" title="" data-ripple="">Videos</a> -->
                    <nuxt-link :to="`/user/${user.username}/followers`">Followers</nuxt-link>
                    <nuxt-link :to="`/user/${user.username}/followings`">Following</nuxt-link>
                    <!-- <a class="" href="timeline-groups.html" title="" data-ripple="">Groups</a>
                    <a class="" href="about.html" title="" data-ripple="">about</a>
                    <a class="" href="#" title="" data-ripple="">more</a> -->
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section><!-- top area -->
  </div>
</template>
