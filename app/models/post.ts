import { User } from "./user";

export interface Post {
  id: number;
  content: string;
  user: Pick<User, 'id' | 'username'>;
  like_count: number;
  is_liked: boolean;
  created_at: string | Date;
  repost?: Post
}
