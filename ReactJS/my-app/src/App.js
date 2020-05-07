
//vi
//sheel script
//bash_profile //usr
//bash_rc //home
//profile //var/log


//ls,rm,tourch,col
//chmod


import React from 'react';
import './Components/Header'
import './App.css';
import Header from './Components/Header';

import SeasonDisplay from './Components/seasons';
import Spinner from './Components/Spinner';


import { BrowserRouter, Link, Route } from 'react-router-dom';

const pageOne = () => {
  return <div className='container'>Page 1<br />
    <button><Link to='/p2'>Next Page</Link></button></div>
}
const pageTwo = () => {
  return <div className='container'>Page 2<br />

    <button> <Link to='/'>Back Page</Link></button>
    <button> <Link to='/p3/3'>Next Page</Link></button></div>
}
const pageThree = (props) => {
  return <div className='container'>

    Page {props.match.params.num}<br />

    <button> <Link to='/'>Back To First Page</Link></button></div>
}


class App extends React.Component {

  constructor() {
    super();
    this.state = {
      it: '',
      lg: '',
      errorMessage: '',
      peoples:
        [{
          name: 'Ronny',
          age: 21

        }, {
          name: 'Sugianto',
          age: 20
        }],

    }
  }


  componentDidMount() {
    window.navigator.geolocation.getCurrentPosition((position) => this.setState({ lg: position.coords.longitude, lt: position.coords.latitude }), (err) => this.setState({ errorMessage: err.message }));
  }


  renderContent() {
    if (this.state.errorMessage) {
      return (<p>Error : {this.state.errorMessage} </p>);
    }
    if (!this.state.errorMessage && this.state.lt) {
      return (
        <div className='container mt-3'>

          <p>Latitude : {this.state.lt} </p>
          <p>Longitude : {this.state.lg} </p>
          <SeasonDisplay />

        </div>
      );
    }
    return <div className='mt-3'>
      <Spinner />
    </div>
  }

  render() {

    //window.navigator.geolocation.getCurrentPosition((position) => console.log(position), (err) => console.log(err));

    return (<div>

      <Header />
      <BrowserRouter>
        <div>
          <Route path='/' exact component={pageOne} />
          <Route path='/p2' exact component={pageTwo} />
          <Route path='/p3/:num' exact component={pageThree} />
        </div>
      </BrowserRouter>
    </div>);
  }
}

export default App;
