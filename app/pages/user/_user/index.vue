<script lang="ts" setup>
import type * as T from '~/models';

import { useRoute, useContext, useFetch } from '@nuxtjs/composition-api';
import Post from '~/components/Post.vue';
import UserHeader from '~/components/UserHeader.vue';

const { $axios } = useContext();
const route = $(useRoute());

let user = $ref<T.UserFull>();
let posts = $ref<T.Post[]>();
const { fetch: refetch } = useFetch(async () => {
  await Promise.all([
    $axios
      .get(`/users/${route.params.user}`)
      .then(({ data }) => user = data),
    $axios
      .get(`/users/${route.params.user}/feed`)
      .then(({ data }) => posts = data)
  ])
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
                    <!-- <div class="widget">
                        <h4 class="widget-title">Socials</h4>
                        <ul class="socials">
                          <li class="facebook">
                            <a title="" href="#"><i class="fa fa-facebook"></i> <span>facebook</span> <ins>45 likes</ins></a>
                          </li>
                          <li class="twitter">
                            <a title="" href="#"><i class="fa fa-twitter"></i> <span>twitter</span><ins>25 likes</ins></a>
                          </li>
                          <li class="google">
                            <a title="" href="#"><i class="fa fa-google"></i> <span>google</span><ins>35 likes</ins></a>
                          </li>
                        </ul>
                      </div> -->
                    <!-- <div class="widget">
                      <h4 class="widget-title">Shortcuts</h4>
                      <ul class="naves">
                        <li>
                          <i class="ti-clipboard"></i>
                          <a href="newsfeed.html" title="">News feed</a>
                        </li>
                        <li>
                          <i class="ti-mouse-alt"></i>
                          <a href="inbox.html" title="">Inbox</a>
                        </li>
                        <li>
                          <i class="ti-files"></i>
                          <a href="fav-page.html" title="">My pages</a>
                        </li>
                        <li>
                          <i class="ti-user"></i>
                          <a href="timeline-friends.html" title="">friends</a>
                        </li>
                        <li>
                          <i class="ti-image"></i>
                          <a href="timeline-photos.html" title="">images</a>
                        </li>
                        <li>
                          <i class="ti-video-camera"></i>
                          <a href="timeline-videos.html" title="">videos</a>
                        </li>
                        <li>
                          <i class="ti-comments-smiley"></i>
                          <a href="messages.html" title="">Messages</a>
                        </li>
                        <li>
                          <i class="ti-bell"></i>
                          <a href="notifications.html" title="">Notifications</a>
                        </li>
                        <li>
                          <i class="ti-share"></i>
                          <a href="people-nearby.html" title="">People Nearby</a>
                        </li>
                        <li>
                          <i class="fa fa-bar-chart-o"></i>
                          <a href="insights.html" title="">insights</a>
                        </li>
                        <li>
                          <i class="ti-power-off"></i>
                          <a href="landing.html" title="">Logout</a>
                        </li>
                      </ul>
                    </div> -->
                    <!-- Shortcuts -->
                    <!-- <div class="widget">
                      <h4 class="widget-title">Recent Activity</h4>
                      <ul class="activitiez">
                        <li>
                          <div class="activity-meta">
                            <i>10 hours Ago</i>
                            <span><a href="#" title="">Commented on Video posted </a></span>
                            <h6>by <a href="newsfeed.html">black demon.</a></h6>
                          </div>
                        </li>
                        <li>
                          <div class="activity-meta">
                            <i>30 Days Ago</i>
                            <span><a href="newsfeed.html" title="">Posted your status. “Hello guys, how are you?”</a></span>
                          </div>
                        </li>
                        <li>
                          <div class="activity-meta">
                            <i>2 Years Ago</i>
                            <span><a href="#" title="">Share a video on her timeline.</a></span>
                            <h6>"<a href="newsfeed.html">you are so funny mr.been.</a>"</h6>
                          </div>
                        </li>
                      </ul>
                    </div> -->
                    <!-- recent activites -->
                    <!-- <div class="widget stick-widget">
                      <h4 class="widget-title">Who's follownig</h4>
                      <ul class="followers">
                        <li>
                          <figure><img src="images/resources/friend-avatar2.jpg" alt=""></figure>
                          <div class="friend-meta">
                            <h4><a href="time-line.html" title="">Kelly Bill</a></h4>
                            <a href="#" title="" class="underline">Add Friend</a>
                          </div>
                        </li>
                        <li>
                          <figure><img src="images/resources/friend-avatar4.jpg" alt=""></figure>
                          <div class="friend-meta">
                            <h4><a href="time-line.html" title="">Issabel</a></h4>
                            <a href="#" title="" class="underline">Add Friend</a>
                          </div>
                        </li>
                        <li>
                          <figure><img src="images/resources/friend-avatar6.jpg" alt=""></figure>
                          <div class="friend-meta">
                            <h4><a href="time-line.html" title="">Andrew</a></h4>
                            <a href="#" title="" class="underline">Add Friend</a>
                          </div>
                        </li>
                        <li>
                          <figure><img src="images/resources/friend-avatar8.jpg" alt=""></figure>
                          <div class="friend-meta">
                            <h4><a href="time-line.html" title="">Sophia</a></h4>
                            <a href="#" title="" class="underline">Add Friend</a>
                          </div>
                        </li>
                        <li>
                          <figure><img src="images/resources/friend-avatar3.jpg" alt=""></figure>
                          <div class="friend-meta">
                            <h4><a href="time-line.html" title="">Allen</a></h4>
                            <a href="#" title="" class="underline">Add Friend</a>
                          </div>
                        </li>
                      </ul>
                    </div>who's following -->
                  </aside>
                </div><!-- sidebar -->
                <div class="col-lg-6">
                  <!-- <div class="central-meta">
                    <PostForm @submit="refreshPosts" />
                  </div>add post new box -->
                  <div class="loadMore">
                    <div
                      v-for="post of posts"
                      :key="post.id"
                      class="central-meta item"
                    >
                      <Post :post="post" @repost="refresh" />
                    </div>
                  </div>
                </div><!-- centerl meta -->
                <div class="col-lg-3">
                  <aside class="sidebar static">
                    <!-- <div class="widget">
                      <div class="banner medium-opacity bluesh">
                        <div style="background-image: url(images/resources/baner-widgetbg.jpg)" class="bg-image"></div>
                        <div class="baner-top">
                          <span><img src="images/book-icon.png" alt=""></span>
                          <i class="fa fa-ellipsis-h"></i>
                        </div>
                        <div class="banermeta">
                          <p>
                            create your own favourit page.
                          </p>
                          <span>like them all</span>
                          <a href="#" title="" data-ripple="">start now!</a>
                        </div>
                      </div>
                    </div>
                    <div class="widget friend-list stick-widget">
                      <h4 class="widget-title">Friends</h4>
                      <div id="searchDir"></div>
                      <ul id="people-list" class="friendz-list">
                        <li>
                          <figure>
                            <img src="images/resources/friend-avatar.jpg" alt="">
                            <span class="status f-online"></span>
                          </figure>
                          <div class="friendz-meta">
                            <a href="time-line.html">bucky barnes</a>
                            <i><a href="https://wpkixx.com/cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="4136282f352433322e2d25243301262c20282d6f222e2c">[email&#160;protected]</a></i>
                          </div>
                        </li>
                        <li>
                          <figure>
                            <img src="images/resources/friend-avatar2.jpg" alt="">
                            <span class="status f-away"></span>
                          </figure>
                          <div class="friendz-meta">
                            <a href="time-line.html">Sarah Loren</a>
                            <i><a href="https://wpkixx.com/cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="3a585b48545f497a5d575b535614595557">[email&#160;protected]</a></i>
                          </div>
                        </li>
                        <li>
                          <figure>
                            <img src="images/resources/friend-avatar3.jpg" alt="">
                            <span class="status f-off"></span>
                          </figure>
                          <div class="friendz-meta">
                            <a href="time-line.html">jason borne</a>
                            <i><a href="https://wpkixx.com/cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="127873617d7c7052757f737b7e3c717d7f">[email&#160;protected]</a></i>
                          </div>
                        </li>
                        <li>
                          <figure>
                            <img src="images/resources/friend-avatar4.jpg" alt="">
                            <span class="status f-off"></span>
                          </figure>
                          <div class="friendz-meta">
                            <a href="time-line.html">Cameron diaz</a>
                            <i><a href="https://wpkixx.com/cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="620803110d0c0022050f030b0e4c010d0f">[email&#160;protected]</a></i>
                          </div>
                        </li>
                        <li>

                          <figure>
                            <img src="images/resources/friend-avatar5.jpg" alt="">
                            <span class="status f-online"></span>
                          </figure>
                          <div class="friendz-meta">
                            <a href="time-line.html">daniel warber</a>
                            <i><a href="https://wpkixx.com/cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="0963687a66676b496e64686065276a6664">[email&#160;protected]</a></i>
                          </div>
                        </li>
                        <li>

                          <figure>
                            <img src="images/resources/friend-avatar6.jpg" alt="">
                            <span class="status f-away"></span>
                          </figure>
                          <div class="friendz-meta">
                            <a href="time-line.html">andrew</a>
                            <i><a href="https://wpkixx.com/cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="5b313a283435391b3c363a323775383436">[email&#160;protected]</a></i>
                          </div>
                        </li>
                        <li>

                          <figure>
                            <img src="images/resources/friend-avatar7.jpg" alt="">
                            <span class="status f-off"></span>
                          </figure>
                          <div class="friendz-meta">
                            <a href="time-line.html">amy watson</a>
                            <i><a href="https://wpkixx.com/cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="472d263428292507202a262e2b6924282a">[email&#160;protected]</a></i>
                          </div>
                        </li>
                        <li>

                          <figure>
                            <img src="images/resources/friend-avatar5.jpg" alt="">
                            <span class="status f-online"></span>
                          </figure>
                          <div class="friendz-meta">
                            <a href="time-line.html">daniel warber</a>
                            <i><a href="https://wpkixx.com/cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="7a101b091514183a1d171b131654191517">[email&#160;protected]</a></i>
                          </div>
                        </li>
                        <li>

                          <figure>
                            <img src="images/resources/friend-avatar2.jpg" alt="">
                            <span class="status f-away"></span>
                          </figure>
                          <div class="friendz-meta">
                            <a href="time-line.html">Sarah Loren</a>
                            <i><a href="https://wpkixx.com/cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="7c1e1d0e12190f3c1b111d1510521f1311">[email&#160;protected]</a></i>
                          </div>
                        </li>
                      </ul>
                      <div class="chat-box">
                        <div class="chat-head">
                          <span class="status f-online"></span>
                          <h6>Bucky Barnes</h6>
                          <div class="more">
                            <span><i class="ti-more-alt"></i></span>
                            <span class="close-mesage"><i class="ti-close"></i></span>
                          </div>
                        </div>
                        <div class="chat-list">
                          <ul>
                            <li class="me">
                              <div class="chat-thumb"><img src="images/resources/chatlist1.jpg" alt=""></div>
                              <div class="notification-event">
                                <span class="chat-message-item">
                                  Hi James! Please remember to buy the food for tomorrow! I’m gonna be handling the gifts and Jake’s gonna get the drinks
                                </span>
                                <span class="notification-date"><time datetime="2004-07-24T18:18" class="entry-date updated">Yesterday at 8:10pm</time></span>
                              </div>
                            </li>
                            <li class="you">
                              <div class="chat-thumb"><img src="images/resources/chatlist2.jpg" alt=""></div>
                              <div class="notification-event">
                                <span class="chat-message-item">
                                  Hi James! Please remember to buy the food for tomorrow! I’m gonna be handling the gifts and Jake’s gonna get the drinks
                                </span>
                                <span class="notification-date"><time datetime="2004-07-24T18:18" class="entry-date updated">Yesterday at 8:10pm</time></span>
                              </div>
                            </li>
                            <li class="me">
                              <div class="chat-thumb"><img src="images/resources/chatlist1.jpg" alt=""></div>
                              <div class="notification-event">
                                <span class="chat-message-item">
                                  Hi James! Please remember to buy the food for tomorrow! I’m gonna be handling the gifts and Jake’s gonna get the drinks
                                </span>
                                <span class="notification-date"><time datetime="2004-07-24T18:18" class="entry-date updated">Yesterday at 8:10pm</time></span>
                              </div>
                            </li>
                          </ul>
                          <form class="text-box">
                            <textarea placeholder="Post enter to post..."></textarea>
                            <div class="add-smiles">
                              <span title="add icon" class="em em-expressionless"></span>
                            </div>
                            <div class="smiles-bunch">
                              <i class="em em---1"></i>
                              <i class="em em-smiley"></i>
                              <i class="em em-anguished"></i>
                              <i class="em em-laughing"></i>
                              <i class="em em-angry"></i>
                              <i class="em em-astonished"></i>
                              <i class="em em-blush"></i>
                              <i class="em em-disappointed"></i>
                              <i class="em em-worried"></i>
                              <i class="em em-kissing_heart"></i>
                              <i class="em em-rage"></i>
                              <i class="em em-stuck_out_tongue"></i>
                            </div>
                            <button type="submit"></button>
                          </form>
                        </div>
                      </div>
                    </div> -->
                    <!-- friends list sidebar -->
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
