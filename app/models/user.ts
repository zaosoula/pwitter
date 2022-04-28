import { Post } from '~/models/post';
export interface User {
  email: string;
  username: string;
  sign_in_count: number;
  current_sign_in_at: string | Date;
  last_sign_in_at: string | Date;
  current_sign_in_ip: string;
  last_sign_in_ip: string;
  confirmed_at: string | Date;
  confirmation_sent_at: string | Date;
  unconfirmed_email: string;
  created_at: string | Date;
  updated_at: string | Date;
  posts: Post[];
}
