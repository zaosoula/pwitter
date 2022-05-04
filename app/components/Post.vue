<script lang="ts" setup>
  import { useProfilePicture } from '~/hooks/profilePicture';
  import { useEnrichContent } from '../hooks/enrichContent';
  import { Post } from '~/models/post';
  import IconHeart from '~/components/icon/heart.vue';
  import IconHeartFilled from '~/components/icon/heart-filled.vue';
  import { useContext } from '@nuxtjs/composition-api';

  const { data: post } = defineProps<{
    data: Post
  }>();

  const { $axios } = useContext();

  const content = useEnrichContent(props.post);

  const handleLike = async () => {
    console.log(props.post)
    props.post.is_liked ? await $axios.delete(`/likes/${props.post.id}`) : await $axios.post(`/likes`, { post_id: props.post.id });
    props.post.is_liked = !props.post.is_liked;
    props.post.like_count = props.post.is_liked ? props.post.like_count + 1 : props.post.like_count -1;

  const computeRelativeTime = (time: string | Date) => {
    if(typeof time === 'string') {
      time = new Date(time);
    }

    const plural = (num: number) => num !== 1 ? 's' : '';
    const format = (value: number, unit: string) => `${value} ${unit}${plural(value)} ago`;

    let diff = (Date.now() - time.getTime()) / 1000;

    if (diff<60) {
      return format(diff, 'second');
    }

    diff = Math.round(diff/60);
    if (diff<60) {
      return format(diff, 'minute');
    }

    diff = Math.round(diff/60);
    if (diff<24){
      return format(diff, 'hour');
    }

    diff = Math.round(diff/24);
    if (diff<7){
      return format(diff, 'day');
    }

    diff = Math.round(diff/7);
    if (diff<4){
      return format(diff, 'week');
    }

    return `on ${time.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })}`;
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
        <div class="we-video-info">
          <ul>
            <!-- <li>
              <span class="comment" data-toggle="tooltip" title="" data-original-title="Comments">
                <i class="fa fa-comments-o"></i>
                <ins>52</ins>
              </span>
            </li> -->
            <li>
              <span class="like" data-toggle="tooltip" title="" data-original-title="like" @click.prevent="handleLike">
                <component :is="post.is_liked ? IconHeartFilled : IconHeart" />
                <ins>{{post.like_count}}</ins>
              </span>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<style>
svg {
  width: 1em;
  height: 1em;
  color: inherit;
}
</style>
