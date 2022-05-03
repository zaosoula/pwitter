import { Post } from "~/models/post";

const enrichContent = (content: string) => content
  .replace(/#([\w\d_]+)/g, `<nuxt-link to="/hashtag/$1">#$1</nuxt-link>`) // Hashtags
  .replace(/@([\w\d_.]+)/g, `<nuxt-link to="/user/$1">@$1</nuxt-link>`); // Mentions

export const useEnrichContent = (obj: string | Post): {name: string, template: string} => {
  if(typeof obj === 'string') {
    return useEnrichContent({ content: obj } as Post);
  }

  const content = `<div>${enrichContent(obj.content)}</div>`;

  console.log(content);
  return {
    name: "PostContent",
    template: content
  }
}
