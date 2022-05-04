<script lang="ts" setup>
  import dayjs from 'dayjs';
  import LocalizedFormat from 'dayjs/plugin/LocalizedFormat';

  import { useProfilePicture } from '~/hooks/profilePicture';
  import { useEnrichContent } from '../hooks/enrichContent';
  import { Post } from '~/models/post';

  dayjs.extend(LocalizedFormat)


  const { data: post } = defineProps<{
    data: Post
  }>();

  const content = useEnrichContent(post);

  const computeRelativeTime = (time: string | Date) => {
    if(typeof time === 'string') {
      time = new Date(time);
    }

    const plural = (num: number) => num !== 1 ? 's' : '';

    let diff = (Date.now() - time.getTime()) / 1000;
    console.log(Date.now(), time.getTime(), diff);
    if (diff<60) {
      return `${diff} second${plural(diff)} ago`;
    }

    diff = Math.round(diff/60);
    if (diff<60) {
      return `${diff} minute${plural(diff)} ago`;
    }
    diff = Math.round(diff/60);
    if (diff<24){
      return `${diff} hour${plural(diff)} ago`;
    }
    diff = Math.round(diff/24);
    if (diff<7){
      return `${diff} day${plural(diff)} ago`;
    }
    diff = Math.round(diff/7);
    if (diff<4){
      return `${diff} week${plural(diff)} ago`;
    }
    return `on ${dayjs(time).format('LL')}`;
  }
</script>

<template>
  <div class="user-post">
    <div class="friend-info">
      <figure>
        <a :href="`/user/${post.user.username}`" title=""><img :src="useProfilePicture(post.user.username || post.user.email)"></a>
      </figure>
      <div class="friend-name">
        <ins><a :href="`/user/${post.user.username}`" title="">{{ post.user.username }}</a></ins>
        <span>{{ computeRelativeTime(post.created_at) }}</span>
      </div>
      <div class="post-meta">
        <div class="description">
          <component :is="content" />
        </div>
      </div>
    </div>
  </div>
</template>
