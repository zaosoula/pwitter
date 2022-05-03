<script lang="ts" setup>
import type { UserFull } from '~/models';

import { useRoute, useContext, useFetch } from '@nuxtjs/composition-api';
import { useProfilePicture } from '~/hooks/profilePicture';
import UserHeader from '~/components/UserHeader.vue';

const { $axios } = useContext();
const route = $(useRoute());

let user = $ref<UserFull>();
let followings = $ref<any>();

useFetch(async () => {
   const [userResponse, followingsResponse] = await Promise.all([$axios.get(`/users/${route.params.user}`), $axios.get(`/users/${route.params.user}/followings`)]);
   user = userResponse.data;
   followings = followingsResponse.data;
})
</script>

<style>

.feature-photo .featured-photo {
  aspect-ratio: 3;
  object-fit: cover;
}
</style>

<template>
  <div v-if="user">
    <UserHeader :user="user" />
    <section>
      <div class="gap gray-bg">
        <div class="container-fluid">
          <div class="row">
            <div class="col-lg-12">
              <div class="row" id="page-contents">
                <div class="col-lg-3">
                  <aside class="sidebar static">

                  </aside>
                </div><!-- sidebar -->
                <div class="col-lg-6">
                  <div class="central-meta">
                    <div class="frnds">
											<ul class="nearby-contct">
                        <li v-for="following in followings" :key="following.target.id">
                          <div class="nearly-pepls">
                            <figure>
                              <nuxt-link :to="`/user/${following.target.username}`"><img :src="useProfilePicture(following.target)"></nuxt-link>
                            </figure>
                            <div class="pepl-info">
                              <h4><nuxt-link :to="`/user/${following.target.username}`">@{{ following.target.username }}</nuxt-link></h4>
                              <!-- <a href="#" title="" class="add-butn more-action" data-ripple="">unfriend</a>
                              <a href="#" title="" class="add-butn" data-ripple="">add friend</a> -->
                            </div>
                          </div>
                        </li>
                      </ul>
										</div>
                  </div>
                </div><!-- centerl meta -->
                <div class="col-lg-3">
                  <aside class="sidebar static">
                                      </aside>
                </div><!-- sidebar -->
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>
