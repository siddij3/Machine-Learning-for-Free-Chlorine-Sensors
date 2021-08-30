function [theta, J] = linearRegression(X, y, theta, alpha, num_iters)
  %COMPUTECOST Compute cost for linear regression with one or many variables
  %   J = COMPUTECOST(X, y, theta) computes the cost of using theta as the
  %   parameter for linear regression to fit the data points in X and y
  %GRADIENTDESCENT Performs gradient descent to learn theta
  % works for single variables and multi variables as well
  %   theta = GRADIENTDESCENT(X, y, theta, alpha, num_iters) updates theta by 
  %   taking num_iters gradient steps with learning rate alpha

  % Initialize some useful values
   

  % Initialize some useful values
  m = length(y); % number of training examples

  % You need to return the following variables correctly 
  J = 0;

  % ====================== YOUR CODE HERE ======================
  % Instructions: Compute the cost of a particular choice of theta
  %               You should set J to the cost.

  % ====================== YOUR CODE HERE ======================
  % Instructions: Perform a single gradient step on the parameter vector
  %               theta. 
  %
  % Hint: While debugging, it can be useful to print out the values
  %       of the cost function (computeCost) and gradient here.
  %



  error_sqr = (X*theta - y).^2;
  q = sum(error_sqr);
  J = 1/(2*m)*q;

 
  for iter = 1:num_iters

      h = X*theta;
      errors = h -y;
      step_term = X'*errors*(1/m*alpha);
      theta = theta - step_term; %step term is teh change in theta



  end


% =========================================================================

end

