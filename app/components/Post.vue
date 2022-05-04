<script lang="ts">
export default {
  name: "Post"
}
</script>
<script lang="ts" setup>
  import { useContext, computed } from '@nuxtjs/composition-api';

  import * as T from '~/models/post';

  import { useProfilePicture } from '~/hooks/profilePicture';
  import { useEnrichContent } from '~/hooks/enrichContent';
  import IconHeart from '~/components/icon/heart.vue';
  import IconHeartFilled from '~/components/icon/heart-filled.vue';
  import IconRepeat from '~/components/icon/repeat.vue';


  const props = defineProps<{
    post: T.Post
    repost?: boolean
  }>();

  const { $axios } = useContext();

  const content = useEnrichContent(props.post);

  const isReposting = computed(() => typeof props.post.repost !== 'undefined');

  const handleLike = async () => {
    console.log(props.post);
    await $axios(`/posts/${props.post.id}/like`, {
      method: props.post.is_liked ? 'DELETE' : 'POST',
    });
    props.post.is_liked = !props.post.is_liked;
    props.post.like_count = props.post.is_liked ? props.post.like_count + 1 : props.post.like_count -1;
  }

  const handleRepost = async () => {
    const { data } = await $axios.post('/posts', {
      repost_id: props.post.id
    });
  }

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
        <nuxt-link :to="`/user/${post.user.username}`" title=""><img :src="useProfilePicture(post.user.username || post.user.email)"></nuxt-link>
      </figure>
      <div class="friend-name">
        <ins><nuxt-link :to="`/user/${post.user.username}`" title="">{{ post.user.username }}</nuxt-link></ins>
        <span>{{ computeRelativeTime(post.created_at) }}</span>
      </div>
      <div class="post-meta">
        <div class="description">
          <component :is="content" />
          <div class="repost_container" v-if="isReposting">
            <Post repost :post="post.repost"/>
          </div>
        </div>
        <div class="we-video-info" v-if="!repost">
          <ul>
            <!-- <li>
              <span class="comment" data-toggle="tooltip" title="" data-original-title="Comments">
                <i class="fa fa-comments-o"></i>
                <ins>52</ins>
              </span>
            </li> -->
            <li>
              <span class="like" data-toggle="tooltip" title="" data-original-title="Like" @click.prevent="handleLike">
                <component :is="post.is_liked ? IconHeartFilled : IconHeart" />
                <ins>{{post.like_count}}</ins>
              </span>
            </li>
            <li>
              <span class="repost" data-toggle="tooltip" title="" data-original-title="Repost" @click.prevent="handleRepost">
                <IconRepeat />
                <ins>{{post.repost_count}}</ins>
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

.repost_container {
  margin-top: 1em;
  padding: 1em;
  border: 1px solid #ede9e9;
}
</style>
