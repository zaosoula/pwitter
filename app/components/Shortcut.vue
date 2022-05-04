<template>
  <div class="widget">
    <h4 class="widget-title">Shortcuts</h4>
    <ul class="naves">
      <li>
        <i class="ti-home"></i>
        <nuxt-link to="/">Home</nuxt-link>
      </li>
      <li>
        <i class="ti-user"></i>
        <nuxt-link :to="`/user/${$auth.user.username}`">My Profile</nuxt-link>
      </li>
      <!-- <li>
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
      </li> -->
      <li>
        <i class="ti-power-off"></i>
        <a href="#" @click.prevent="() => $auth.logout()">Logout</a>
      </li>
    </ul>
  </div><!-- Shortcuts -->
</template>
