import { useContext } from '@nuxtjs/composition-api';
import { User } from '~/models';

const getUrl = (str: string) => `https://avatars.dicebear.com/api/adventurer-neutral/${str}.svg?scale=69&flip=1`;

export const useProfilePicture = (obj?: string | User) => {
  if(!obj) {
    const { $auth: { user } } = useContext();
    return getUrl((user?.username || user?.email || 'anonymous') as string);
  }

  if(typeof obj === 'string') {
    return getUrl(obj);
  }

  return getUrl(obj.username || obj.email);
}
