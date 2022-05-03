<script lang="ts" setup>
import type { UserFull } from '~/models';

import { useRoute, useContext, useFetch } from '@nuxtjs/composition-api';
import { useProfilePicture } from '~/hooks/profilePicture';
import UserHeader from '~/components/UserHeader.vue';

const { $axios } = useContext();
const route = $(useRoute());

let user = $ref<UserFull>();
let followers = $ref<any>();

useFetch(async () => {
   const [userResponse, followersResponse] = await Promise.all([$axios.get(`/users/${route.params.user}`), $axios.get(`/users/${route.params.user}/followers`)]);
   user = userResponse.data;
   followers = followersResponse.data;
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
                        <li v-for="follower in followers" :key="follower.source.id">
                          <div class="nearly-pepls">
                            <figure>
                              <nuxt-link :to="`/user/${follower.source.username}`"><img :src="useProfilePicture(follower.source)"></nuxt-link>
                            </figure>
                            <div class="pepl-info">
                              <h4><nuxt-link :to="`/user/${follower.source.username}`">@{{ follower.source.username }}</nuxt-link></h4>
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
