<template>
<div>
	<div class="responsive-header">
		<div class="mh-head first Sticky">
			<span class="mh-btns-left">
				<a class="" href="#menu"><i class="fa fa-align-justify"></i></a>
			</span>
			<span class="mh-text" style="height: 35px">
			</span>
		</div>
	</div><!-- responsive header -->

	<div class="topbar stick">
		<div class="logo">
			<nuxt-link to="/"><img src="https://github.com/ezyostudio/assets/raw/main/icon-blue.svg" alt=""></nuxt-link>
		</div>

		<div class="top-area">
			<ul class="main-menu">
        <li><nuxt-link to="/">Home</nuxt-link></li>
      </ul>
			<div class="user-img">
				<nuxt-link :to="`/user/${$auth.user.username}`">
          <img :src="`https://avatars.dicebear.com/api/adventurer-neutral/${$auth.user.username}.svg?scale=69&flip=1`" width="50px" height="50px" alt="">
        </nuxt-link>
				<span class="status f-online"></span>
			</div>
		</div>
	</div><!-- topbar -->
</div>

</template>

<style>
  .logo img {
    height: 45px;
    margin-right: 45px;
  }
</style>
