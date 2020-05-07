import React from 'react';
import axios from 'axios';


export default class Posts extends React.Component {
    constructor() {
        super();

        this.state = {
            post: []
        }
    }
    componentDidMount() {
        axios.get('https://jsonplaceholder.typicode.com/posts').then(res => {
            const post = res.data;
            this.setState({ post });
        })
    }
    render() {


        return <div>
            <ul>
                {this.state.post.map(person => <li>{person.title}</li>)}
            </ul>

        </div>;
    }
}