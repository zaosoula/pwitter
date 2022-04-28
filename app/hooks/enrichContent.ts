import { Post } from "~/models/post";

const enrichContent = (content: string) => content
  .replace(/#([\w\d_]+)/g, `<a href="/hashtag/$1">#$1</a>`) // Hashtags
  .replace(/@([\w\d_.]+)/g, `<a href="/user/$1">@$1</a>`); // Mentions

export const useEnrichContent = (obj: string | Post) => {
  if(typeof obj === 'string') {
    return enrichContent(obj);
  }

  return {
    ...obj,
    content: enrichContent(obj.content),
  }
}
