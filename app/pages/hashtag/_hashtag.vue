<script setup lang="ts">
  import Shortcut from '~/components/Shortcut.vue';
  import PostForm from '~/components/PostForm.vue';
  import Post from '~/components/Post.vue';
  import { useProfilePicture } from '~/hooks/profilePicture';
  import { useContext, useFetch, useRoute } from '@nuxtjs/composition-api';

  const { $axios } = useContext();
  const profilePicture = useProfilePicture();
  const route = $(useRoute());

  let posts = $ref([]);
  const hashtag = route.params.hashtag;

  const { fetch: refreshPosts } = useFetch(async () => {
   const response = await $axios.get(`/feed/hashtag/${hashtag}`);
   posts = response.data;
  })
</script>

<template>
  <section>
		<div class="gap gray-bg">
			<div class="container-fluid">
				<div class="row">
					<div class="col-lg-12">
						<div class="row" id="page-contents">
							<div class="col-lg-3">
								<aside class="sidebar static">
									<Shortcut />
								</aside>
							</div><!-- sidebar -->
													<div class="col-lg-6">
								<div class="central-meta">
									<PostForm @submit="refreshPosts" :defaultContent="`#${hashtag}`"/>
								</div><!-- add post new box -->
								<div class="loadMore">
                  <div
                    v-for="post of posts"
                    :key="post.id"
                    class="central-meta item"
                  >
                    <Post :post="post" @repost="refreshPosts" />
                  </div>
								</div>
							</div>
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
</template>
