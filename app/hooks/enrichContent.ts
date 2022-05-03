import { Post } from "~/models/post";

const enrichContent = (content: string) => content
  .replace(/#([\w\d_]+)/g, `<nuxt-link to="/hashtag/$1">#$1</nuxt-link>`) // Hashtags
  .replace(/@([\w\d_.]+)/g, `<nuxt-link to="/user/$1">@$1</nuxt-link>`); // Mentions

export const useEnrichContent = (obj: string | Post): {name: string, template: string} => {
  if(typeof obj === 'string') {
    return useEnrichContent({ content: obj } as Post);
  }

  return {
    name: "PostContent",
    template: `<div>${enrichContent(obj.content)}</div>`
  }
}
