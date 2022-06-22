export interface SoundPacks {
    id: number;
    color: string;
    color2: string;
    title: string;
    description: string;
    image: string;
    status: Status;
    voices: IVoice[];
}

export interface IVoice {
    id: number;
    name: string;
    status: string;
    job: string;
}

export enum Status {
    public = 'Publique',
    private = 'Privée',
    unlisted = 'Non repertoriée'
}

export const StatusArray = Object.values(Status);
