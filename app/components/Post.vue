<script lang="ts" setup>
  import { useProfilePicture } from '~/hooks/profilePicture';
  import { useEnrichContent } from '../hooks/enrichContent';
  import { Post } from '~/models/post';

  const props = defineProps<{
    data: Post
  }>();

  const post = useEnrichContent(props.data);
</script>

<template>
  <div class="user-post">
    <div class="friend-info">
      <figure>
        <a :href="`/user/${post.user.username}`" title=""><img :src="useProfilePicture(post.user.username || post.user.email)"></a>
      </figure>
      <div class="friend-name">
        <ins><a :href="`/user/${post.user.username}`" title="">{{ post.user.username }}</a></ins>
        <span>{{ post.created_at }}</span>
      </div>
      <div class="post-meta">
        <div class="description">
          <p v-html="post.content"></p>
        </div>
      </div>
    </div>
  </div>
</template>
