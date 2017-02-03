class BaseComponent extends React.Component {
    _bind(...methods) {
        methods.forEach((method) => this[method] = this[method].bind(this));
    }
}

// react class notes
// anoynomous functions being declared in a for, loop, or map are much slower than declared functions that are called withing the high order function that is looping
  // - moral of story dont put anoynamous functionality in your map functions
// with arrow functions I dont need my classic bind function that I always use because it doesnt change the context of "this"
// it is bad to have event listening functions change state directly, they should instead change state through a callback
// switch statements dont break automatically, and you probabaly always want a default case


// New Relic
// talk about really liking data and thats why Im doing the Data Vis class, so I can visualize data in the best way possible. Also the reason I have have so many maps in my apps is because I really like making data available.

// New Relic on AWS platform gives insights into how their platform is performing. Lets them know when things are being hit too hard or when they are not being used, this allows servers to be taken down when not needed and money saved.

// Using the SSH protocol, I can connect and authenticate to remote servers and services
