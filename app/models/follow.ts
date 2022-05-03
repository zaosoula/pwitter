import { User } from './user';
export interface Follow {
  id: string;
  created_at: string | Date;
  target?: User;
  source?: User;
}
