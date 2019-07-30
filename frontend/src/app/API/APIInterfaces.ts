export class APIResult {
  success: boolean;
  error: string;
  payload: any;
}

export class Message {
  image: string;
  transition: string;
}

export class APIGroupStageResult {
  groups: [
    {
      id: number,
      name: string,
      group_number: number,
      position: number,
      color: string,
      wins: number,
      loses: number
    }
  ]
}
